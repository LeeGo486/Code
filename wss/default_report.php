<?php require_once('config/tank_config.php'); ?>
<?php require_once('session_unset.php'); ?>
<?php require_once('session.php'); ?>
<?php


if (!function_exists("GetSQLValueString")) {
    function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "")
    {
        if (PHP_VERSION < 6) {
            $theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
        }

        $theValue = function_exists("mysql_real_escape_string") ? mysql_real_escape_string($theValue) : mysql_escape_string($theValue);

        switch ($theType) {
            case "text":
                $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
                break;
            case "long":
            case "int":
                $theValue = ($theValue != "") ? intval($theValue) : "NULL";
                break;
            case "double":
                $theValue = ($theValue != "") ? doubleval($theValue) : "NULL";
                break;
            case "date":
                $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
                break;
            case "defined":
                $theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
                break;
        }
        return $theValue;
    }
}

//指向自身的PHP
$currentPage = $_SERVER["PHP_SELF"];


mysql_select_db($database_tankdb, $tankdb);

$query_Recordset_sumtotal = sprintf("SELECT 
							COUNT(*) as count_prj   
							FROM tk_project 	
							WHERE project_to_user = %s",
    GetSQLValueString($_SESSION['MM_uid'], "int")
);
$Recordset_sumtotal = mysql_query($query_Recordset_sumtotal, $tankdb) or die(mysql_error());
$row_Recordset_sumtotal = mysql_fetch_assoc($Recordset_sumtotal);
$my_totalprj = $row_Recordset_sumtotal['count_prj'];

$pagetab = 'all';
if (isset($_GET['pagetab'])) {
    $pagetab = $_GET['pagetab'];
}
?>

<?php require('head.php'); ?>

<div class="subnav">
    <div class="float_left" style="width:85%">
        <div class="btn-group" role="group">
            <a type="button" class="btn btn-default btn-sm <?php if ($pagetab == 'all') {
                echo "active";
                unset($_SESSION['project']);
                unset($_SESSION['task_status']);
                unset($_SESSION['task_pm']);
                unset($_SESSION['task_begin_date']);
                unset($_SESSION['task_end_date']);
                unset($_SESSION['csa_text']);
            } ?>" href="<?php echo $currentPage; ?>?pagetab=all">
                <?php echo $multilingual_report_all; ?></a>
            <a type="button" class="btn btn-default btn-sm <?php if ($pagetab == 'single'){
                echo "active";
                unset($_SESSION['project']);
                unset($_SESSION['task_status']);
                unset($_SESSION['task_pm']);
                unset($_SESSION['task_begin_date']);
                unset($_SESSION['task_end_date']);
                unset($_SESSION['csa_text']);
            }?>" href="<?php echo $currentPage; ?>?pagetab=single">
                <?php echo $multilingual_report_single; ?></a>
            <a type="button" class="btn btn-default btn-sm <?php if ($pagetab == 'day') {
                echo "active";
                unset($_SESSION['project']);
                unset($_SESSION['task_status']);
                unset($_SESSION['task_pm']);
                unset($_SESSION['task_begin_date']);
                unset($_SESSION['task_end_date']);
                unset($_SESSION['csa_text']);
            } ?>" href="<?php echo $currentPage; ?>?pagetab=day">
                <?php echo $multilingual_report_day; ?></a>
        </div>

    </div>

</div>
<div class="clearboth"></div>
<div class="pagemargin">

    <?php require('control_report.php'); ?>

</div>
<?php require('foot.php'); ?>

</body>
</html>