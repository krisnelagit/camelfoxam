<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Karworx - <decorator:title default="Welcome!" /></title>
        <link href="css/main.css" rel="stylesheet" type="text/css" />
        <link href="css/other_style.css" rel="stylesheet" type="text/css" />
        <link href="css/dropdown.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-1.10.2.min.js"></script>

        <decorator:head/>

        <link rel="shortcut icon" href="images/krisnela_technologies.ico"></link>
    </head>

    <body>
        <c:if test="${sessionScope.USERTYPE.equals('crm')}">
            <div class="topheader"></div>
            <header>
                <div class="container-header">
                    <a href="crm_Dashboard?prefixid=A"><div class="logo"></div></a>
                    <div class="example">
                        <ul id="nav">
                            <li><a href="#">Customer relationship management (CRM)</a>
                                <ul>
                                    <li><a href="enquiriesgridlink">Enquiries</a></li>
                                    <li><a href="followupgridlink">Follow ups</a></li>
                                    <li><a href="appointmentCalendarlink">Appointments</a></li>
                                    <li><a href="viewInsuranceExpiringGridLink">Insurance Expiring</a></li>
                                    <li><a href="fbgridLink">Feedback</a></li>
                                    <li><a href="customerAdvanceGridLink">Customer advance</a></li>
                                    <li><a href="CustomerSearchLink">Customer Search</a></li>
                                </ul>
                            </li>
                            <table width="70" class="settings-right">
                                <tr>
                                    <td><a href="logout"><div class="logout-admin"></div></a></td>
                                </tr>
                            </table>
                        </ul>
                    </div>
            </header>
        </c:if>
        <c:if test="${sessionScope.USERTYPE.equals('spares')}">
            <div class="topheader"></div>
            <header>
                <div class="container-header">
                    <a href="gotobranchinfo?prefixid=A"><div class="logo"></div></a>
                    <div class="example">
                        <ul id="nav">
                            <li><a href="estimate">Dashboard</a></li>
                            <li><a href="#">Transaction</a>
                                <ul>
                                    <li><a href="service_checklist_grid.html">Service Checklist</a></li>
                                    <li><a href="180pointchecklistgridlink">180 Point Checklist</a></li>
                                    <li><a href="estimate.html">Estimate</a></li>
                                    <li><a href="viewJobsheetGridLink">Jobsheet</a></li>
                                    <li><a href="viewSpareRequisitionGrid">Spare Requisition</a></li>
                                    <li><a href="viewJobsheetVerificationGridLink">Jobsheet Verification</a></li>
                                    <li><a href="invoiceMasterLink">Invoice</a></li>
                                    <li><a href="cleaningListLink">Cleaning List</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Accounts</a>
                                <ul>
                                    <li><a href="PurchaseOrderGridLink">Purchase Order</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Inventory</a>
                                <ul>
                                    <li><a href="viewVehicleList">Spare Parts</a></li>
                                    <li><a href="viewGenericVehicleList">Generic Parts</a></li>
                                    <li><a href="viewConsumableVehicleList">Paints</a></li>
                                    <li><a href="viewreceivables">Receivables</a></li>
                                </ul>
                            </li>
                            <table width="70" class="settings-right">
                                <tr>
                                    <td><a href="logout"><div class="logout-admin"></div></a></td>
                                </tr>
                            </table>
                        </ul>
                    </div>
            </header>
        </c:if>
        <c:if test="${sessionScope.USERTYPE.equals('floor manager')}">
            <div class="topheader"></div>
            <header>
                <div class="container-header">
                    <a href="gotobranchinfo?prefixid=A"><div class="logo"></div></a>
                    <div class="example">
                        <ul id="nav">
                            <li><a href="#">Transaction</a>
                                <ul>
                                    <li><a href="service_checklist_grid.html">Service Checklist</a></li>
                                    <li><a href="180pointchecklistgridlink">180 Point Checklist</a></li>
                                    <li><a href="estimate.html">Estimate</a></li>
                                    <li><a href="viewJobsheetGridLink">Jobsheet</a></li>
                                    <li><a href="viewSpareRequisitionGrid">Spare Requisition</a></li>
                                    <li><a href="viewJobsheetVerificationGridLink">Jobsheet Verification</a></li>
                                    <li><a href="invoiceMasterLink">Invoice</a></li>
                                    <li><a href="cleaningListLink">Cleaning List</a></li>
                                </ul>
                            </li>
                            <li><a href="#">CRM</a>
                                <ul>
                                    <li><a href="enquiriesgridlink">Enquiries</a></li>
                                    <li><a href="followupgridlink">Follow ups</a></li>
                                    <li><a href="appointmentCalendarlink">Appointments</a></li>
                                    <li><a href="viewInsuranceExpiringGridLink">Insurance Expiring</a></li>
                                    <li><a href="fbgridLink">Feedback</a></li>
                                    <li><a href="customerAdvanceGridLink">Customer advance</a></li>
                                    <li><a href="CustomerSearchLink">Customer Search</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Accounts</a>
                                <ul>
                                    <li><a href="PurchaseOrderGridLink">Purchase Order</a></li>
                                    <li><a href="generalExpenseLink">General Expense</a></li>
                                        <c:if test="${sessionScope.BRANCHNAME=='MPO'}">
                                        <li><a href="purchaseorderappovalsLink">Purchase Order Approvals</a></li>
                                        <li><a href="expenseappovalsLink">Expense Approvals</a></li>
                                        </c:if>
                                    <li><a href="VendorPaymentGridLink">Vendor Payments</a></li>
                                    <li><a href="generalIncomeLink">General Income</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Inventory</a>
                                <ul>
                                    <li><a href="viewVehicleList">Spare Parts</a></li>
                                    <li><a href="viewGenericVehicleList">Generic Parts</a></li>
                                    <li><a href="viewConsumableVehicleList">Paints</a></li>
                                    <li><a href="viewreceivables">Receivables</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Features</a>
                                <ul>
                                    <li><a href="viewAttendance">View Attendance</a></li>
                                    <li><a href="attendanceAddLink">Add Attendance</a></li>
                                    <li><a href="viewSynchronizationLink">Synchronization</a></li>
                                    <li><a href="#">Reports</a></li>
                                    <li><a href="reminderCustomerLink">Customer reminder</a></li>
                                </ul>
                            </li> 
                            <table width="70" class="settings-right">
                                <tr>
                                    <td><a href="logout"><div class="logout-admin"></div></a></td>
                                </tr>
                            </table>


                        </ul>
                    </div>
            </header>
        </c:if>
        <c:if test="${sessionScope.USERTYPE.equals('admin')}">
            <div class="topheader"></div>
            <header>
                <div class="container-header">
                    <a href="gotobranchinfo?prefixid=A"><div class="logo"></div></a>
                    <div class="example">
                        <ul id="nav">
                            <li><a href="#">Transaction</a>
                                <ul>
                                    <li><a href="service_checklist_grid.html">Service Checklist</a></li>
                                    <li><a href="180pointchecklistgridlink">180 Point Checklist</a></li>
                                    <li><a href="estimate.html">Estimate</a></li>
                                    <li><a href="viewJobsheetGridLink">Jobsheet</a></li>
                                    <li><a href="viewSpareRequisitionGrid">Spare Requisition</a></li>
                                    <li><a href="viewJobsheetVerificationGridLink">Jobsheet Verification</a></li>
                                    <li><a href="invoiceMasterLink">Invoice</a></li>
                                    <!--<li><a href="paymentMasterLink">Payment</a></li>-->
                                    <li><a href="cleaningListLink">Cleaning List</a></li>
                                </ul>
                            </li>
                            <li><a href="#">CRM</a>
                                <ul>
                                    <li><a href="enquiriesgridlink">Enquiries</a></li>
                                    <li><a href="followupgridlink">Follow ups</a></li>
                                    <li><a href="appointmentCalendarlink">Appointments</a></li>
                                    <li><a href="viewInsuranceExpiringGridLink">Insurance Expiring</a></li>
                                    <li><a href="fbgridLink">Feedback</a></li>
                                    <li><a href="customerAdvanceGridLink">Customer advance</a></li>
                                    <li><a href="CustomerSearchLink">Customer Search</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Accounts</a>
                                <ul>
                                    <li><a href="PurchaseOrderGridLink">Purchase Order</a></li>
                                    <li><a href="generalExpenseLink">General Expense</a></li>
                                        <c:if test="${sessionScope.BRANCHNAME=='MPO'}">
                                        <li><a href="purchaseorderappovalsLink">Purchase Order Approvals</a></li>
                                        <li><a href="expenseappovalsLink">Expense Approvals</a></li>
                                        </c:if>
                                    <li><a href="VendorPaymentGridLink">Vendor Payments</a></li>
                                    <li><a href="generalIncomeLink">General Income</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Inventory</a>
                                <ul>
                                    <li><a href="viewVehicleList">Spare Parts</a></li>
                                    <li><a href="viewGenericVehicleList">Generic Spare Parts</a></li>
                                    <li><a href="viewConsumableVehicleList">Paints</a></li>
                                    <li><a href="viewreceivables">Receivables</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Masters</a>
                                <ul>
                                    <li><a href="customerMasterLink">Customer Master</a></li>
                                    <li><a href="serviceMasterLink">Service Master</a></li>
                                    <li><a href="taxMasterLink">Tax Master</a></li>
                                    <li><a href="viewWorkmanLink">Workman Master</a></li>
                                    <li><a href="brandMasterLink">Brand Master</a></li>
                                    <li><a href="vendorMasterLink">Vendor Master</a></li>
                                    <li><a href="mfgMasterLink">Manufacture Master</a></li>
                                    <li><a href="categoryMasterLink">Category Master</a></li>
                                    <li><a href="approvalMasterLink">Approval Master</a></li>
                                    <li><a href="ledgerMasterLink">Ledger Master</a></li>
                                    <li><a href="bankAccountMasterLink">Bank A/c Master</a></li>
                                    <!--<li><a href="expense-master-list.html">Expense Master</a></li>-->
                                    <li><a href="branchMasterLink">Branch Master</a></li>
                                    <li><a href="insuranceCompanyMasterLink">Insurance Company Master</a></li>
                                    <!--<li><a href="service-master-list.html">Service Master</a></li>-->
                                </ul>
                            </li>
                            <li><a href="#">Features</a>
                                <ul>
                                    <li><a href="viewAttendance">View Attendance</a></li>
                                    <li><a href="attendanceAddLink">Add Attendance</a></li>
                                    <li><a href="viewSynchronizationLink">Synchronization</a></li>
                                    <li><a href="#">Reports</a></li>
                                    <li><a href="reminderCustomerLink">Customer reminder</a></li>
                                </ul>
                            </li> 
                            <table width="70" class="settings-right">
                                <tr>
                                    <td><a href="logout"><div class="logout-admin"></div></a></td>
                                </tr>
                            </table>


                        </ul>
                    </div>
            </header>
        </c:if>
        <div class="container">
            <c:if test="${sessionScope.USERTYPE.equals('spares')}">
                <div class="box_container">

                    <div class="box"> 
                        <a href="newnotifiedestimate.html">
                            <div class="box02">
                                <div class="img02">
                                    <img src="images/eslitmate_icon.png" width="25" height="35" /><span class="notification-counts">${sessionScope.ESTIMATECOUNT}</span>
                                </div>
                                <div class="text03">New Estimate</div>
                            </div>
                        </a> 
                    </div> 
                    <div class="box">
                        <a href="lowQuantityPartPageLink.html">
                            <div class="box02">
                                <div class="img02">
                                    <img src="images/eslitmate_icon.png" width="25" height="35" /><span class="notification-counts">${sessionScope.QUANTITYCOUNT}</span>
                                </div>
                                <div class="text03">Item's needed</div>
                            </div>
                        </a> 
                    </div> 
                    <div class="box"> 
                        <a href="viewNewSpareRequisitionGrid.html">
                            <div class="box02">
                                <div class="img02">
                                    <img src="images/eslitmate_icon.png" width="25" height="35" /><span class="notification-counts">${sessionScope.REQUISITIONCOUNT}</span>
                                </div>
                                <div class="text03">New Spare Requisition</div>
                            </div>
                        </a> 
                    </div> 

                </div>
            </c:if>
            <div id="modps" class="ps">
                <decorator:body/>

            </div>
        </div>
    </body>
</html>