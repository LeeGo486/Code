<?php
session_start();
//无数据
$no_data = '<div class="alert alert-warning" style="margin:6px;">' . $multilingual_default_sorrytipup . '</div>';
//每页行数
$maxRows_Recordset1 = get_item('maxrows_report');
//页码编号,默认0开始
$pageNum_Recordset1 = 0;
if (isset($_GET['pageNum_Recordset1'])) {
    $pageNum_Recordset1 = $_GET['pageNum_Recordset1'];
};
//起始行数
$startRow_Recordset1 = $pageNum_Recordset1 * $maxRows_Recordset1;

//筛选变量
$project = '';
$task_status = '';
$task_pm = '';
$task_begin_date = '';
$task_end_date = '';
$csa_text = '';
$where = ' AND 1=1 ';
//日期选择情况
$copy;
//查询处理
if (isset($_POST['button11'])) {
    if ($pagetab == 'all') {
        $project = $_POST['select_project'];
        $task_status = $_POST['select_st'];
        $task_pm = $_POST['csa_to_user'];
        $task_begin_date = $_POST['plan_start'];
        $task_end_date = $_POST['plan_end'];
        $csa_text = '';
        if (!empty($project)) {
            $where = $where . " AND id = $project ";
            $_SESSION['project'] = $project;
        };
        if (!empty($task_status)) {
            $where = $where . " AND task_status_id = $task_status ";
            $_SESSION['task_status'] = $task_status;
        };
        if (!empty($task_pm)) {
            $where = $where . " AND uid = $task_pm ";
            $_SESSION['task_pm'] = $task_pm;
        };
        if (!empty($task_begin_date)) {
            $where = $where . " AND csa_plan_st >= '$task_begin_date' ";
            $_SESSION['task_begin_date'] = $task_begin_date;
        };
        if (!empty($task_end_date)) {
            $where = $where . " AND csa_plan_et <= '$task_end_date'";
            $_SESSION['task_end_date'] = $task_end_date;
        };
        $_SESSION['search_where_all'] = $where;
    } elseif ($pagetab == 'day') {
        $project = '';
        $task_status = '';
        $csa_text = '';
        $task_pm = $_POST['csa_to_user'];
        $task_begin_date = $_POST['plan_start'];
        $task_end_date = $_POST['plan_end'];
        unset($_SESSION['task_status']);
        unset($_SESSION['csa_text']);
        unset($_SESSION['project']);
        if (!empty($task_pm)) {
            $where = $where . " AND csa_tb_backup2 = $task_pm ";
            $_SESSION['task_pm'] = $task_pm;
        };
        if (!empty($task_begin_date)) {
            $task_begin_date = str_replace('-', '', $task_begin_date);
            $where = $where . " AND csa_tb_year >= '$task_begin_date' ";
            $_SESSION['task_begin_date'] = $task_begin_date;
        };
        if (!empty($task_end_date)) {
            $task_end_date = str_replace('-', '', $task_end_date);
            $where = $where . " AND csa_tb_year <= '$task_end_date'";
            $_SESSION['task_end_date'] = $task_end_date;
        };
        $_SESSION['search_where_day'] = $where;
    } elseif ($pagetab == 'single') {
        unset($_SESSION['task_status']);
        $task_status = '';
        $project = $_POST['select_project'];
        $csa_text = $_POST['csa_text'];
        $task_pm = $_POST['csa_to_user'];
        $task_begin_date = $_POST['plan_start'];
        $task_end_date = $_POST['plan_end'];

        if (!empty($project)) {
            $where = $where . ' AND T1.id = ' . $project;
            $_SESSION['project'] = $project;
        };
        if (!empty($csa_text)) {
            $where = $where . ' AND t1.tid = ' . $csa_text;
            $_SESSION['csa_text'] = $csa_text;
        };
        if (!empty($task_pm)) {
            $where = $where . " AND T1.uid = '" . $task_pm . "'";
            $_SESSION['task_pm'] = $task_pm;
        };
        if (!empty($task_begin_date)) {
            $where = $where . " AND T1.csa_plan_st >= '$task_begin_date'";
            $_SESSION['task_begin_date'] = $task_begin_date;
        };
        if (!empty($task_end_date)) {
            $where = $where . " AND T1.csa_plan_et <= '$task_end_date'";
            $_SESSION['task_end_date'] = $task_end_date;
        };
        $_SESSION['search_where_single'] = $where;
    };
};

mysql_select_db($database_tankdb, $tankdb);
$query_tkstatus = "SELECT * FROM tk_status ORDER BY task_status_backup1 ASC";
$tkstatus = mysql_query($query_tkstatus, $tankdb) or die(mysql_error());
$row_tkstatus = mysql_fetch_assoc($tkstatus);
$totalRows_tkstatus = mysql_num_rows($tkstatus);

mysql_select_db($database_tankdb, $tankdb);
$query_Recordset_type = "SELECT * FROM tk_task_tpye ORDER BY task_tpye_backup1 ASC";
$Recordset_type = mysql_query($query_Recordset_type, $tankdb) or die(mysql_error());
$row_Recordset_type = mysql_fetch_assoc($Recordset_type);
$totalRows_Recordset_type = mysql_num_rows($Recordset_type);

//需求下拉
mysql_select_db($database_tankdb, $tankdb);
$query_single_Report_select = "SELECT * FROM tk_task  WHERE csa_remark4 = -1 ORDER BY csa_project ASC";
$single_report_result = mysql_query($query_single_Report_select, $tankdb) or die(mysql_error());

mysql_select_db($database_tankdb, $tankdb);
$query_Recordset_project = "SELECT * FROM tk_project inner join tk_status_project on tk_project.project_status=tk_status_project.psid WHERE task_status NOT LIKE '%$multilingual_dd_status_prjfinish%' ORDER BY project_name ASC";
$Recordset_project = mysql_query($query_Recordset_project, $tankdb) or die(mysql_error());
$row_Recordset_project = mysql_fetch_assoc($Recordset_project);
$totalRows_Recordset_project = mysql_num_rows($Recordset_project);

mysql_select_db($database_tankdb, $tankdb);
$query_Recordset2 = "SELECT uid,tk_display_name FROM tk_user WHERE tk_user_rank NOT IN ('5') ORDER BY tk_display_name ASC";
$Recordset2 = mysql_query($query_Recordset2, $tankdb) or die(mysql_error());
$totalRows_Recordset2 = mysql_num_rows($Recordset2);

//每日汇报情况
mysql_select_db($database_tankdb, $tankdb);
$report_byday_query_basic = 'SELECT T1.csa_tb_year,T4.tk_display_name,T2.csa_text,T1.csa_tb_manhour,' .
    ' T1.csa_tb_lastupdate,T3.task_status_display,T1.csa_tb_text' .
    ' FROM tk_task_byday T1 LEFT JOIN tk_task T2 ON T1.csa_tb_backup1 = T2.TID' .
    ' LEFT JOIN tk_status T3 ON T1.csa_tb_status = T3.id' .
    ' LEFT JOIN tk_user T4 ON T1.csa_tb_backup2 = T4.uid WHERE 1=1 ';
//判断SESSION
if (isset($_SESSION['search_where_day'])) {
    $report_byday_query_totle = $report_byday_query_basic . $_SESSION['search_where_day'];
    $report_byday_query_data = $report_byday_query_basic . $_SESSION['search_where_day'] .
        ' ORDER BY T1.csa_tb_year,T4.tk_display_name DESC LIMIT ' . $startRow_Recordset1 . ' , ' . $maxRows_Recordset1;
} else {
    $report_byday_query_totle = $report_byday_query_basic . ' AND csa_tb_year >= ' . date('Ymd');
    $report_byday_query_data = $report_byday_query_basic . ' AND csa_tb_year >= ' . date('Ymd') .
        ' ORDER BY T1.csa_tb_year,T4.tk_display_name DESC LIMIT ' . $startRow_Recordset1 . ' , ' . $maxRows_Recordset1;
};
$result_byday_totle = mysql_query($report_byday_query_totle, $tankdb) or die(mysql_error());
$result_byday_data = mysql_query($report_byday_query_data, $tankdb) or die(mysql_error());

$byday_count = mysql_num_rows($result_byday_totle);

//整体报表
mysql_select_db($database_tankdb, $tankdb);
$page_power = $_SESSION['MM_rank'];
$page_user = $_SESSION['MM_uid'];
$page_search = '1=1';
$where = '';
$report_all_query_basic = 'SELECT * FROM tk_report_all WHERE ';

switch ($page_power) {
    case 5:
        $page_search = $page_search . ' AND 1=1 ';
        break;
    case 4:
        $page_search = $page_search . " AND project_to_user = $page_user";
        break;
    default:
        $page_search = $page_search . " AND uid = $page_user";
        break;
};

$report_all_query_basic = $report_all_query_basic . $page_search;
//判断SESSION
if (isset($_SESSION['search_where_all'])) {
    $report_all_query_totle = $report_all_query_basic . $_SESSION['search_where_all'];
    $report_all_query_data = $report_all_query_basic . $_SESSION['search_where_all'] .
        ' ORDER BY id,project_name,csa_text LIMIT ' . $startRow_Recordset1 . ' , ' . $maxRows_Recordset1;
} else {
    $report_all_query_totle = $report_all_query_basic;
    $report_all_query_data = $report_all_query_basic . ' ORDER BY id,project_name,csa_text LIMIT ' .
        $startRow_Recordset1 . ' , ' . $maxRows_Recordset1;
};
$result_all_totle = mysql_query($report_all_query_totle, $tankdb) or die(mysql_error());
$result_all_data = mysql_query($report_all_query_data, $tankdb) or die(mysql_error());

$all_count = mysql_num_rows($result_all_totle);

//单需求报表
mysql_select_db($database_tankdb, $tankdb);
$query_single_report_basic = 'SELECT T1.project_name AS project_name ,T1.csa_text AS task_name,T1.task_user_name AS PM ' .
    ',T1.csa_plan_st AS task_begin ,T1.csa_plan_et AS task_end ,T2.TID AS job_tid' .
    ',T2.csa_text AS job_name,T3.tk_display_name AS job_display_name' .
    ',T4.task_status_display AS job_status,T2.csa_plan_st AS job_plan_st' .
    ',T2.csa_plan_et AS job_plan_et,T2.csa_plan_hour AS job_plan_hour' .
    ',SUM(T5.csa_tb_manhour) AS job_hour '.
    ' FROM tk_report_all T1 LEFT JOIN tk_task T2 ON T1.tid = T2.csa_remark4 AND T2.csa_remark6 = 2 ' .
    ' LEFT JOIN tk_user T3 ON T2.csa_to_user = T3.uid ' .
    ' LEFT JOIN tk_status T4 ON T2.csa_remark2 = T4.id '.
    ' LEFT JOIN tk_task_byday T5 ON T2.TID = T5.csa_tb_backup1 WHERE 1=1 ';
$single_Id = '';
$single_Tid = '';
$query_single_report_totle = '';
$query_single_report_data = '';

if ($_GET['single_id']) {
    $single_Id = $_GET['single_id'];
};
if ($_GET['single_tid']) {
    $single_Tid = $_GET['single_tid'];
};

if (!empty($single_Id)) {
    $query_single_report_totle = $query_single_report_basic . ' AND T1.id = ' . $single_Id .' GROUP BY T1.tid,T2.TID';
    $query_single_report_data = $query_single_report_basic . '  AND T1.id = ' . $single_Id
        . ' GROUP BY T1.tid,T2.csa_plan_st ORDER BY T1.tid LIMIT ' . $startRow_Recordset1 . ' , ' . $maxRows_Recordset1;
} elseif (!empty($single_Tid)) {
    $query_single_report_totle = $query_single_report_basic . ' AND T1.tid = ' . $single_Tid .' GROUP BY T1.tid,T2.TID';
    $query_single_report_data = $query_single_report_basic . ' AND T1.tid = ' . $single_Tid
        . ' GROUP BY T1.tid,T2.csa_plan_st ORDER BY T1.tid LIMIT ' . $startRow_Recordset1 . ' , ' . $maxRows_Recordset1;
} elseif ($_SESSION['search_where_single']) {
    $query_single_report_totle = $query_single_report_basic . $_SESSION['search_where_single'] .' GROUP BY T1.tid,T2.TID';
    $query_single_report_data = $query_single_report_basic . $_SESSION['search_where_single']
        . ' GROUP BY T1.tid,T2.csa_plan_st ORDER BY T1.tid LIMIT ' . $startRow_Recordset1 . ' , ' . $maxRows_Recordset1;
} else {
    $query_single_report_totle = $query_single_report_basic;
    $query_single_report_data = $query_single_report_basic .
        ' GROUP BY T1.tid,T2.csa_plan_st ORDER BY T1.tid LIMIT ' . $startRow_Recordset1 . ' , ' . $maxRows_Recordset1;
};


$result_single_totle = mysql_query($query_single_report_totle, $tankdb) or die(mysql_error());
$result_single_data = mysql_query($query_single_report_data, $tankdb) or die(mysql_error());
$single_count = mysql_num_rows($result_single_totle);

//总行数
if ($pagetab == 'all') {
    //总行数
    $totalRows_Recordset1 = $all_count;
} elseif ($pagetab == 'day') {
    //总行数
    $totalRows_Recordset1 = $byday_count;
} elseif ($pagetab == 'single') {
    $totalRows_Recordset1 = $single_count;
};

//行数统计
$totalPages_Recordset1 = ceil($totalRows_Recordset1 / $maxRows_Recordset1) - 1;

$queryString_Recordset1 = "";
if (!empty($_SERVER['QUERY_STRING'])) {
    $params = explode("&", $_SERVER['QUERY_STRING']);
    $newParams = array();
    foreach ($params as $param) {
        if (stristr($param, "pageNum_Recordset1") == false &&
            stristr($param, "totalRows_Recordset1") == false
        ) {
            array_push($newParams, $param);
        }
    }
    if (count($newParams) != 0) {
        $queryString_Recordset1 = "&" . htmlentities(implode("&", $newParams));
    }
}
$queryString_Recordset1 = sprintf("&totalRows_Recordset1=%d%s", $totalRows_Recordset1, $queryString_Recordset1);
?>

<!--开始处理筛选项目-->
<div class="search_div pagemarginfix">
    <form class="saerch_form form-inline" id="Report" name="ReportForm" method="post" action="
    <?php if ($pagetab == 'all') {
        echo $currentPage . '?pagetab=all';
    } elseif ($pagetab == 'day') {
        echo $currentPage . '?pagetab=day';
    } elseif ($pagetab == 'single') {
        echo $currentPage . '?pagetab=single';
    }; ?>
    ">
        <?php
        if ($pagetab == 'all') {
            ?>
            <select class="form-control input-sm" name="select_project" id="select_project">
                <option value="" select="selected"><?php echo $multilingual_taskf_project; ?></option>
                <?php do { ?>
                    <option value="<?php echo $row_Recordset_project['id'] ?>"
                        <?php
                        if (isset($_SESSION['project'])) {
                            if (!(strcmp($row_Recordset_project['id'], "{$_SESSION['project']}"))) {
                                echo "selected=\"selected\"";
                            };
                        };
                        ?>>
                        <?php echo $row_Recordset_project['project_name'] ?></option>
                <?php
                } while ($row_Recordset_project = mysql_fetch_assoc($Recordset_project));
                $rows = mysql_num_rows($Recordset_project);
                if ($rows > 0) {
                    mysql_data_seek($Recordset_project, 0);
                    $row_Recordset_project = mysql_fetch_assoc($Recordset_project);
                }
                ?>
            </select>
            <!--项目状态-->
            <select class="form-control input-sm" name="select_st" id="select_st">
                <option value=""><?php echo $multilingual_taskf_status; ?></option>
                <?php do { ?>
                    <option value="<?php echo $row_tkstatus['id']; ?>"
                    <?php
                    if (isset($_SESSION['task_status'])) {
                        if (!(strcmp($row_tkstatus['id'], "{$_SESSION['task_status']}"))) {
                            echo "selected=\"selected\"";
                        }
                    }
                    ?>><?php echo $row_tkstatus['task_status'] ?></option>
                <?php
                } while ($row_tkstatus = mysql_fetch_assoc($tkstatus));
                $rows = mysql_num_rows($tkstatus);
                if ($rows > 0) {
                    mysql_data_seek($tkstatus, 0);
                    $row_tkstatus = mysql_fetch_assoc($tkstatus);
                } ?>
            </select>
        <?php
        } elseif ($pagetab == 'single') {
            ?>
            <!--Project-->
            <select class="form-control input-sm" name="select_project" id="select_project">
                <option value="" select="selected"><?php echo $multilingual_taskf_project; ?></option>
                <?php do { ?>
                    <option value="<?php echo $row_Recordset_project['id'] ?>"
                        <?php
                        if (isset($_SESSION['project'])) {
                            if (!(strcmp($row_Recordset_project['id'], "{$_SESSION['project']}"))) {
                                echo "selected=\"selected\"";
                            };
                        };
                        ?>>
                        <?php echo $row_Recordset_project['project_name'] ?></option>
                <?php
                } while ($row_Recordset_project = mysql_fetch_assoc($Recordset_project));
                $rows = mysql_num_rows($Recordset_project);
                if ($rows > 0) {
                    mysql_data_seek($Recordset_project, 0);
                    $row_Recordset_project = mysql_fetch_assoc($Recordset_project);
                }
                ?>
            </select>
            <!--单需求选项下拉-->
            <select id="taskName" name="csa_text" class="form-control input-sm">
                <option value=""><?php echo $multilingual_report_single_title; ?></option>
                <?php while ($row = mysql_fetch_array($single_report_result)) { ?>
                    <option value="<?php echo $row["TID"] ?>"
                     <?php
                        if (isset($_SESSION['csa_text'])) {
                            if (!(strcmp($row["TID"], "{$_SESSION['csa_text']}"))) {
                            echo "selected=\"selected\"";
                            };
                        };
                    ?>>
                        <?php
                        echo $row["csa_text"] ?></option>
                <?php } ?>
            </select>
        <?php
        } elseif ($pagetab == 'day') {
            $copy = -1;
        }
        ?>
        <!--项目经理-->
        <select id="select4" name="csa_to_user" class="form-control input-sm">
            <option value=""><?php echo $multilingual_report_pm_title; ?></option>

            <optgroup label="<?php echo $multilingual_default_task_users; ?>">
                <?php while ($row = mysql_fetch_array($Recordset2)) { ?>
                    <option value="<?php echo $row['uid'] ?>"
                        <?php
                        if (isset($_SESSION['task_pm'])) {
                            if (!(strcmp($row['uid'], "{$_SESSION['task_pm']}"))) {
                                echo "selected=\"selected\"";
                            };
                        };
                        ?>>
                        <?php
                        echo $row["tk_display_name"] ?></option>
                <?php } ?>
            </optgroup>
        </select>
        <!--开始时间-->
        <input class="form-control input-sm" type="text" name="plan_start"
               id="datepicker2" value="<?php if ($copy == -1) {
            echo date('Ymd');
        } else if ($copy == 1) {
            echo $task_arr['start'];
        } ?>"
               placeholder="<?php if ($pagetab == 'day') {
                   echo date('Y-m-d');
               } else {
                   echo $multilingual_default_task_planend;
               }; ?>"/>
        <!--结束时间-->
        <input class="form-control input-sm" type="text" name="plan_end"
               id="datepicker3" value="<?php if ($copy == -1) {
            echo date("Ymd", strtotime("+1 day"));
        } else if ($copy == 1) {
            echo $task_arr['end'];
        } ?>"
               placeholder="<?php if ($pagetab == 'day') {
                   echo date('Y-m-d', strtotime("+1 day"));
               } else {
                   echo $multilingual_default_task_planend;
               }; ?>"/>
        <!--筛选按钮-->
        <button type="submit" name="button11" id="button11" class="btn btn-default btn-sm">
            <span class="glyphicon glyphicon-filter"
                  style="display:inline;"></span><?php echo $multilingual_global_filterbtn; ?>
        </button>
    </form>
    </span>
</div>

<!--开始处理表格-->
<table class="table table-striped table-hover glink" width="98%" align="center">
    <thead>
    <tr>
        <?php
        if ($pagetab == 'all'){
        if ($totalRows_Recordset1 > 0){
        ?>
        <th><?php echo $multilingual_default_task_id; ?></th>
        <th><?php echo '项目名称'; ?></th>
        <th><?php echo '任务名称'; ?></th>
        <th><?php echo '项目经理'; ?></th>
        <th><?php echo '开始日期'; ?></th>
        <th><?php echo '结束日期'; ?></th>
        <th><?php echo '任务状态'; ?></th>
        <th><?php echo '任务类型'; ?></th>
        <th><?php echo '需求PV'; ?></th>
        <th><?php echo '实际PV'; ?></th>
        <?php do{
        if ($row_Recordset1){ ?>
    <tr>
        <td><?php echo $row_Recordset1['id'];?></td>
        <td>
            <a href="<?php echo $currentPage . '?pagetab=single&single_id=' . $row_Recordset1['id']?>">
                <?php echo $row_Recordset1['project_name'];?></a>
        </td>
        <td>
            <a href="<?php echo $currentPage . '?pagetab=single&single_tid=' . $row_Recordset1['tid']?>">
                <?php echo $row_Recordset1['csa_text'];?></a>
        </td>
        <td><?php echo $row_Recordset1['task_user_name'];?></td>
        <td><?php echo $row_Recordset1['csa_plan_st'];?></td>
        <td><?php echo $row_Recordset1['csa_plan_et'];?></td>
        <td><?php echo $row_Recordset1['task_status'];?></td>
        <td><?php echo $row_Recordset1['task_tpye'];?></td>
        <td><?php echo $row_Recordset1['sum_planhour'];?></td>
        <td><?php echo $row_Recordset1['sum_manhour'];?></td>
    </tr>
    <?php
    };
    }while ($row_Recordset1 = mysql_fetch_assoc($result_all_data));
    ?>
    <?php
    } else {
        echo $no_data;
    };
    } elseif ($pagetab == 'day') {
        if ($byday_count > 0) {
            ?>
            <th style="width:120px;"><?php echo '汇报日期'; ?></th>
            <th style="width:100px;"><?php echo '汇报人'; ?></th>
            <th style="width:150px;"><?php echo '汇报项目'; ?></th>
            <th style="width:100px;"><?php echo '汇报工时'; ?></th>
            <th style="width:100px;"><?php echo '需求状态'; ?></th>
            <th style="width:200px;"><?php echo '汇报内容'; ?></th>
            <th style="width:100px;"><?php echo '填报日期'; ?></th>
            <?php do {
                if ($row_Recordset2) { ?>
                    <tr>
                        <td><?php echo $row_Recordset2['csa_tb_year']; ?></td>
                        <td><?php echo $row_Recordset2['tk_display_name']; ?></td>
                        <td><?php echo $row_Recordset2['csa_text']; ?></td>
                        <td><?php echo $row_Recordset2['csa_tb_manhour'] ?></td>
                        <td><?php echo $row_Recordset2['task_status_display']; ?></td>
                        <td><?php echo $row_Recordset2['csa_tb_text']; ?></td>
                        <td><?php echo $row_Recordset2['csa_tb_lastupdate']; ?></td>
                    </tr>
                <?php
                };
            } while ($row_Recordset2 = mysql_fetch_assoc($result_byday_data));
        } else {
            echo $no_data;
        };
    } elseif ($pagetab == 'single') {
        if ($single_count > 0) {
            ?>
            <th style="width:150px;"><?php echo '需求名称'; ?></th>
            <th style="width:150px;"><?php echo '任务名称'; ?></th>
            <th style="width:80px;"><?php echo 'PM'; ?></th>
            <th style="width:80px;"><?php echo '执行人'; ?></th>
            <th style="width:80px;"><?php echo '任务开始'; ?></th>
            <th style="width:80px;"><?php echo '任务完成'; ?></th>
            <th style="width:50px;"><?php echo '任务状态'; ?></th>
            <th style="width:100px;"><?php echo '任务计划PV'; ?></th>
            <th style="width:100px;"><?php echo '任务实际PV'; ?></th>
            <?php do {
                if ($row_Recordset3) { ?>
                    <tr>
                        <td><?php echo $row_Recordset3['task_name']; ?></td>
                        <td><?php echo $row_Recordset3['job_name']; ?></td>
                        <td><?php echo $row_Recordset3['PM']; ?></td>
                        <td><?php echo $row_Recordset3['job_display_name'] ?></td>
                        <td><?php echo $row_Recordset3['job_plan_st']; ?></td>
                        <td><?php echo $row_Recordset3['job_plan_et']; ?></td>
                        <td><?php echo $row_Recordset3['job_status']; ?></td>
                        <td><?php echo $row_Recordset3['job_plan_hour']; ?></td>
                        <td><?php echo $row_Recordset3['job_hour']; ?></td>
                    </tr>
                <?php
                };
            } while ($row_Recordset3 = mysql_fetch_assoc($result_single_data));
        } else {
            echo $no_data;
        };
    }
    ?>
    </tr>
    </thead>
    <tbody>

    </tbody>
</table>
<!--这里处理分页数据-->
<?php
if ($totalRows_Recordset1 > 1) {
    ?>
    <table class="rowcon" border="0" align="center">
        <tr>
            <td>
                <table border="0">
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <table border="0">
                                <tr>
                                    <td><?php if ($pageNum_Recordset1 > 0) { // Show if not first page ?>
                                        <a href="<?php printf("%s?pageNum_Recordset1=%d%s", $currentPage, 0, $queryString_Recordset1); ?>">
                                            <?php echo $multilingual_global_first; ?></a><?php } // Show if not first page
                                        ?>
                                    </td>
                                    <td><?php if ($pageNum_Recordset1 > 0) { // Show if not first page ?>
                                            <a href="<?php printf("%s?pageNum_Recordset1=%d%s", $currentPage, max(0, $pageNum_Recordset1 - 1), $queryString_Recordset1); ?>">
                                                <?php echo $multilingual_global_previous; ?></a>
                                        <?php } // Show if not first page
                                        ?>
                                    </td>
                                    <td><?php if ($pageNum_Recordset1 < $totalPages_Recordset1) { // Show if not last page ?>
                                            <a href="<?php printf("%s?pageNum_Recordset1=%d%s", $currentPage, min($totalPages_Recordset1, $pageNum_Recordset1 + 1), $queryString_Recordset1); ?>"><?php echo $multilingual_global_next; ?></a>
                                        <?php } // Show if not last page
                                        ?>
                                    </td>
                                    <td><?php if ($pageNum_Recordset1 < $totalPages_Recordset1) { // Show if not last page ?>
                                            <a href="<?php printf("%s?pageNum_Recordset1=%d%s", $currentPage, $totalPages_Recordset1, $queryString_Recordset1); ?>"><?php echo $multilingual_global_last; ?></a>
                                        <?php } // Show if not last page
                                        ?>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td align="right"><?php echo($startRow_Recordset1 + 1) ?><?php echo $multilingual_global_to; ?><?php echo min($startRow_Recordset1 + $maxRows_Recordset1, $totalRows_Recordset1) ?>
                (<?php echo $multilingual_global_total; ?> <?php echo $totalRows_Recordset1 ?>)
            </td>
        </tr>
    </table>
<?php } ?>
</div>

