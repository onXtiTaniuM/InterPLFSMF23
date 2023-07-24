/**
 * 
 */

//lot form temp
var lottemplate = [
    {
    	name: 'lotno',
        bind: 'lotno',
        type: 'text',
        label: 'LOT 번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'prodno',
        bind: 'prodno',
        type: 'text',
        label: '상품번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px'
    },
    {
    	name: 'materno',
        bind: 'materno',
        type: 'text',
        label: '재료번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px'
    },
	{
    	name: 'qty',
        bind: 'qty',
        type: 'text',
        label: '수 량',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
	{
    	name: 'whesno',
        bind: 'whseno',
        type: 'text',
        label: '저장 위치',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'lotsubButton',
        type: 'button',
        text: '재고로트 입력',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initLotForm(){
	var lotinsertform = $('#lotinsertform');
	lotinsertform.jqxForm({
        template: lottemplate,
        value: [],
        padding: { left: 10, top: 10, right: 0, bottom: 10 }
	});
    var subbtn = lotinsertform.jqxForm('getComponentByName', 'lotsubButton');
    subbtn.on('click', function () {
    	updateUser();
    });	
}

var lotuptemplate = [
    {
    	name: 'lotno',
        bind: 'lotno',
        type: 'text',
        label: 'LOT 번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'prodno',
        bind: 'prodno',
        type: 'text',
        label: '상품번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px'
    },
    {
    	name: 'materno',
        bind: 'materno',
        type: 'text',
        label: '재료번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px'
    },
	{
    	name: 'qty',
        bind: 'qty',
        type: 'text',
        label: '수 량',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
	{
    	name: 'whesno',
        bind: 'whseno',
        type: 'text',
        label: '저장 위치',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'lotupsubButton',
        type: 'button',
        text: '재고로트 수정',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initLotUpForm(){
	var lotupdateform = $('#lotupdateform');
	lotupdateform.jqxForm({
	    template: lotuptemplate,
	    value: [],
	    padding: { left: 10, top: 10, right: 0, bottom: 10 }
	});
	var subbtn = lotupdateform.jqxForm('getComponentByName', 'lotupsubButton');
	subbtn.on('click', function () {
		updateUser();
	});	
}

var whtemplate = [
    {
    	name: 'whseno',
        bind: 'whseno',
        type: 'text',
        label: '창고 번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'whseloc',
        bind: 'whseloc',
        type: 'text',
        label: '창고 위치',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
 	{
    	name: 'whsename',
        bind: 'whsename',
        type: 'text',
        label: '창고 이름',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'whsubButton',
        type: 'button',
        text: '신규창고 입력',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initWhForm(){
	var warehsinsertform = $('#warehsinsertform');
	        		warehsinsertform.jqxForm({
		                template: whtemplate,
		                value: [],
		                padding: { left: 10, top: 10, right: 0, bottom: 10 }
	            	});
		            var subbtn = warehsinsertform.jqxForm('getComponentByName', 'whsubButton');
		            subbtn.on('click', function () {
		            	updateUser();
		            });	
}

var prodtemplate = [
    {
    	name: 'prodno',
        bind: 'prodno',
        type: 'text',
        label: '상품 코드',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'prodname',
        bind: 'prodname',
        type: 'text',
        label: '상품 이름',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
 	{
    	name: 'prodprice',
        bind: 'prodprice',
        type: 'text',
        label: '상품 가격',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'category',
        bind: 'category',
        type: 'text',
        label: '상품 분류',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'leadtime',
        bind: 'leadtime',
        type: 'text',
        label: 'Lead Time',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'prodsubButton',
        type: 'button',
        text: '상품 입력',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initProdForm(){
	var prodinsertform = $('#prodinsertform');
	        		prodinsertform.jqxForm({
		                template: prodtemplate,
		                value: [],
		                padding: { left: 10, top: 10, right: 0, bottom: 10 }
	            	});
		            var subbtn = prodinsertform.jqxForm('getComponentByName', 'prodsubButton');
		            subbtn.on('click', function () {
		            	updateUser();
		            });	
}

var matertemplate = [
    {
    	name: 'materno',
        bind: 'materno',
        type: 'text',
        label: '자재 코드',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'matername',
        bind: 'matername',
        type: 'text',
        label: '자재 이름',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
 	{
    	name: 'materprice',
        bind: 'materprice',
        type: 'text',
        label: '자재 단가',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
    	name: 'unit',
        bind: 'unit',
        type: 'text',
        label: '단 위',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        required: true
    },
    {
        type: 'blank',
        rowHeight: '20px',
    },
    {
        name: 'matersubButton',
        type: 'button',
        text: '재고로트 입력',
        align: 'right',
        padding: {left: 0, top: 5, bottom: 5, right: 40}
    }
]

function initMaterForm(){
	var materinsertform = $('#materinsertform');
	        		materinsertform.jqxForm({
		                template: matertemplate,
		                value: [],
		                padding: { left: 10, top: 10, right: 0, bottom: 10 }
	            	});
		            var subbtn = materinsertform.jqxForm('getComponentByName', 'matersubButton');
		            subbtn.on('click', function () {
		            	updateUser();
		            });	
}

function lotfiller(lotno){
	$.ajax({
              type: 'POST',
              url: 'http://localhost:8584/SMFPlatform/inventory/lotdata.json',
              dataType: 'json',
              async: false,
              data:{lot:lotno},
              success: function(data) {
               	var value = data;
               	$("#lotupdateform").jqxForm("val", value);
              },
              error: function(xhr, status, error) {
                console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
              }
            });
}