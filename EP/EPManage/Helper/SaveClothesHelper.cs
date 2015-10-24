using EPManageWeb.Entities.Models;
using EPManageWeb.Models;
using Lucene.Net.Analysis;
using Lucene.Net.Analysis.Standard;
using Lucene.Net.Documents;
using Lucene.Net.Index;
using Lucene.Net.QueryParsers;
using Lucene.Net.Search;
using Lucene.Net.Store;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Version = Lucene.Net.Util.Version;

namespace EPManageWeb.Helper
{
    public class SaveClothesHelper
    {
        static Version version = Version.LUCENE_30;
        const String INDEX_PATH = "~/LuceneIndex";
        private const String PREFIX = "^";
        private const String SUBFIX = "$";
        static Directory directory = FSDirectory.Open(HttpContext.Current.Server.MapPath(INDEX_PATH));
        static Analyzer analyzer = new WhitespaceAnalyzer();

        public static void RemovePreviousIndex()
        {
            var luceneIndexFile = HttpContext.Current.Server.MapPath(String.Format("{0}/{1}", INDEX_PATH, "segments.gen"));
            if (System.IO.File.Exists(luceneIndexFile))
                System.IO.File.Delete(luceneIndexFile);
        }

        public static void Save(Clothes clothes)
        {
            using (IndexWriter writer = new IndexWriter(directory, analyzer, !directory.FileExists("segments.gen"), new IndexWriter.MaxFieldLength(1000)))
            {
                Document document = new Document();
                document.Add(new Field(Fields.Id.ToString(), clothes.Id.ToString(), Field.Store.YES, Field.Index.ANALYZED));
                document.Add(new Field(Fields.SampleNoIndex.ToString(), PREFIX + (clothes.SampleNO ?? "").ToLower() + SUBFIX, Field.Store.NO, Field.Index.ANALYZED));
                document.Add(new Field(Fields.SampleNO.ToString(), clothes.SampleNO, Field.Store.YES, Field.Index.NO));
                document.Add(new Field(Fields.Tags.ToString(), clothes.Tags.Replace(',', ' '), Field.Store.YES, Field.Index.ANALYZED));
                document.Add(new Field(Fields.ProductNO.ToString(), clothes.ProductNO, Field.Store.YES, Field.Index.NO));
                document.Add(new Field(Fields.ProductNOIndex.ToString(), PREFIX + (clothes.ProductNO ?? "").ToLower() + SUBFIX, Field.Store.NO, Field.Index.ANALYZED));
                document.Add(new Field(Fields.Year.ToString(), ExtractYearFromTags(clothes), Field.Store.YES, Field.Index.ANALYZED));
                document.Add(new Field(Fields.ClothesTypeId.ToString(), clothes.ClothesType.Id.ToString(), Field.Store.YES, Field.Index.ANALYZED));
                document.Add(new Field(Fields.SaledCount.ToString(), clothes.SaledCount.ToString(), Field.Store.YES, Field.Index.ANALYZED));
                document.Add(new Field(Fields.ClothesPics.ToString(), clothes.ClothesPics ?? string.Empty, Field.Store.YES, Field.Index.ANALYZED));
                document.Add(new Field(Fields.ModelVersionPics.ToString(), clothes.ModelVersionPics ?? string.Empty, Field.Store.YES, Field.Index.ANALYZED));
                document.Add(new Field(Fields.StylePics.ToString(), clothes.StylePics ?? string.Empty, Field.Store.YES, Field.Index.ANALYZED));
                document.Add(new Field(Fields.UsedCount.ToString(), clothes.ViewCount.ToString(), Field.Store.YES, Field.Index.ANALYZED));

                //store Tags
                var tags = clothes.Tags.Split(new char[] { ',' });
                Dictionary<string, string> dics = new Dictionary<string, string>();
                Array.ForEach(tags, t =>
                {

                    if (t.IndexOf('-') > -1)
                    {
                        var key = t.Substring(0, t.IndexOf('-'));
                        var value = t.Substring(t.IndexOf('-') + 1);
                        if (dics.ContainsKey(key))
                        {
                            dics[key] = dics[key] + "," + PREFIX + value.ToLower() + SUBFIX;
                        }
                        else
                        {
                            dics.Add(key, PREFIX + value.ToLower() + SUBFIX);
                        }
                    }
                });
                dics.Keys.ToList().ForEach(k =>
                {
                    document.Add(new Field(k, dics[k], Field.Store.YES, Field.Index.ANALYZED));
                });

                writer.AddDocument(document);
                writer.Optimize();
            }
        }

        public static List<Clothes> Search(SearchDocument searchCondition, out int totalCount)
        {
            List<Clothes> clothes = new List<Clothes>();

            if (!System.IO.Directory.Exists(HttpContext.Current.Server.MapPath(INDEX_PATH)) || System.IO.Directory.GetFiles(HttpContext.Current.Server.MapPath(INDEX_PATH)).Length == 0)
            {
                totalCount = 0;
                return clothes;
            }


            QueryParser parser = new QueryParser(version, Fields.Tags.ToString(), analyzer);
            parser.DefaultOperator = QueryParser.Operator.OR;
            var searchQuery = searchCondition.ToSearchDocument();
            Query query = parser.Parse(searchQuery);
            IndexSearcher searcher = new IndexSearcher(directory);
            var sortBy = new Sort(new SortField(Fields.Id.ToString(), SortField.INT, true));
            switch (searchCondition.OrderByField)
            {
                case SearchDocument.Field.SaledCount:
                    sortBy = new Sort(new SortField(Fields.SaledCount.ToString(), SortField.INT, true));
                    break;
                case SearchDocument.Field.ViewedCount:
                    sortBy = new Sort(new SortField(Fields.UsedCount.ToString(), SortField.INT, true));
                    break;
                case SearchDocument.Field.Year:
                    sortBy = new Sort(new SortField(Fields.Year.ToString(), SortField.STRING, true));
                    break;

            }
            var collector = TopFieldCollector.Create(sortBy, 100000, true, true, true, true);
            searcher.Search(query, collector);
            totalCount = collector.TotalHits;

            var docs = collector.TopDocs((searchCondition.PageIndex - 1) * SearchDocument.PAGE_SIZE, SearchDocument.PAGE_SIZE);

            foreach (var t in docs.ScoreDocs)
            {
                if (t != null)
                {
                    clothes.Add(new Clothes()
                    {
                        Id = int.Parse(searcher.Doc(t.Doc).GetField(Fields.Id.ToString()).StringValue),
                        ProductNO = searcher.Doc(t.Doc).GetField(Fields.ProductNO.ToString()).StringValue,
                        SampleNO = searcher.Doc(t.Doc).GetField(Fields.SampleNO.ToString()).StringValue,
                        ClothesPics = searcher.Doc(t.Doc).GetField(Fields.ClothesPics.ToString()).StringValue,
                        StylePics = searcher.Doc(t.Doc).GetField(Fields.StylePics.ToString()).StringValue,
                        ModelVersionPics = searcher.Doc(t.Doc).GetField(Fields.ModelVersionPics.ToString()).StringValue
                    });
                }
            }
            return clothes;
        }

        public static void RemoveDocument(int id)
        {
            QueryParser parser = new QueryParser(version, Fields.Tags.ToString(), new WhitespaceAnalyzer());
            parser.DefaultOperator = QueryParser.Operator.OR;
            Query query = parser.Parse(string.Format("{0}:{1}", Fields.Id.ToString(), id));
            IndexSearcher searcher = new IndexSearcher(directory);
            using (IndexReader reader = IndexReader.Open(directory, false))
            {
                TopDocs hits = searcher.Search(query, 100);
                var term = new Term(Fields.Id.ToString(), id.ToString());
                reader.DeleteDocuments(term);
            }

        }

        private static string ExtractYearFromTags(Clothes clothes)
        {
            if (!String.IsNullOrEmpty(clothes.Tags))
            {
                return System.Text.RegularExpressions.Regex.Match(clothes.Tags, @"\d{4}").Value;
            }
            return string.Empty;
        }

        enum Fields
        {
            Id,
            SampleNO,
            SampleNoIndex,
            ProductNO,
            ProductNOIndex,
            Tags,
            Year,
            SaledCount,
            UsedCount,
            ClothesTypeId,
            ClothesPics,
            StylePics,
            ModelVersionPics
        }
    }
}