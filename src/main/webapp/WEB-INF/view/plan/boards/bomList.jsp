<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title id='Description'>JavaScript PivotGrid - Events Handling Example</title>
    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.base.css" type="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1 maximum-scale=1 minimum-scale=1" />	
    <link rel="stylesheet" href="${path}/resources/jqwidgets/styles/jqx.light.css" type="text/css" />
    <c:set var="path" value="${pageContext.request.contextPath}"/>
    
    <script type="text/javascript" src="${path}/resources/js/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxdata.js"></script> 
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxtextarea.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpivot.js"></script> 
    <script type="text/javascript" src="${path}/resources/jqwidgets/jqxpivotgrid.js"></script>
    <script type="text/javascript" src="${path}/resources/jqwidgets/demos.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // prepare sample data
            var data = new Array();
            var firstNames =
            [
                "Andrew", "Nancy", "Shelley", "Regina", "Yoshi", "Antoni", "Mayumi", "Ian", "Peter", "Lars", "Petra", "Martin", "Sven", "Elio", "Beate", "Cheryl", "Michael", "Guylene"
            ];
            var lastNames =
            [
                "Fuller", "Davolio", "Burke", "Murphy", "Nagase", "Saavedra", "Ohno", "Devling", "Wilson", "Peterson", "Winkler", "Bein", "Petersen", "Rossi", "Vileid", "Saylor", "Bjorn", "Nodier"
            ];
            var productNames =
            [
            	"Black Tea", "Green Tea", "Caffe Espresso", "Doubleshot Espresso", "Caffe Latte", "White Chocolate Mocha", "Cramel Latte", "Caffe Americano", "Cappuccino", "Espresso Truffle", "Espresso con Panna", "Peppermint Mocha Twist"
            ];
            var priceValues =
            [
                "2.25", "1.5", "3.0", "3.3", "4.5", "3.6", "3.8", "2.5", "5.0", "1.75", "3.25", "4.0"
            ];
            for (var i = 0; i < 500; i++) {
                var row = {};
                var productindex = Math.floor(Math.random() * productNames.length);
                var price = parseFloat(priceValues[productindex]);
                var quantity = 1 + Math.round(Math.random() * 10);
                row["firstname"] = firstNames[Math.floor(Math.random() * firstNames.length)];
                row["lastname"] = lastNames[Math.floor(Math.random() * lastNames.length)];
                row["productname"] = productNames[productindex];
                row["price"] = price;
                row["quantity"] = quantity;
                row["total"] = price * quantity;
                data[i] = row;
            }
            // create a data source and data adapter
            var source =
            {
                localdata: data,
                datatype: "array",
                datafields:
                [
                    { name: 'firstname', type: 'string' },
                    { name: 'lastname', type: 'string' },
                    { name: 'productname', type: 'string' },
                    { name: 'quantity', type: 'number' },
                    { name: 'price', type: 'number' },
                    { name: 'total', type: 'number' }
                ]
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            dataAdapter.dataBind();
            
            // create a pivot data source from the dataAdapter
            var pivotDataSource = new $.jqx.pivot(
                dataAdapter,
                {
                    pivotValuesOnRows: false,
                    rows: [{ dataField: 'firstname' }, { dataField: 'lastname'}],
                    columns: [{ dataField: 'productname'}],
                    filters: [
                        {
                            dataField: 'productname',
                            filterFunction: function (value) {
                                if (value == "Black Tea" || value == "Green Tea")
                                    return true;
                                return false;
                            }
                        }
                    ],
                    values: [
                        { dataField: 'price', 'function': 'sum', text: 'sum', formatSettings: { prefix: '$', decimalPlaces: 2} },
                        { dataField: 'price', 'function': 'count', text: 'count' },
                        { dataField: 'price', 'function': 'average', text: 'average', formatSettings: { prefix: '$', decimalPlaces: 2 } }
                    ]
                });
            // create a pivot grid
            $('#divPivotGrid').jqxPivotGrid(
                {
                    source: pivotDataSource,
                    treeStyleRows: false, 
                    multipleSelectionEnabled: false
                });
        });
    </script>
</head>
<body class="default"">
    <div id="divPivotGrid" style="height: 800px; width: 1501px; background-color: white;">
    </div>
</body>
</html>
