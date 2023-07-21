/**
 * 
 */

//lot form temp
var prodoptions;
function SetProductOptions() {
    $.ajax({
      type: 'POST',
      url: 'http://localhost:8584/SMFPlatform/manage/ranklist.json',
      dataType: 'json',
      async: false,
      success: function(data) {
        options = data.map(function(item) {
          return { label: item, value: item };
        });
      },
      error: function(xhr, status, error) {
        console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
      }
    });
  } 

var materoptions;
function SetMaterialOptions() {
    $.ajax({
      type: 'POST',
      url: 'http://localhost:8584/SMFPlatform/manage/ranklist.json',
      dataType: 'json',
      async: false,
      success: function(data) {
        options = data.map(function(item) {
          return { label: item, value: item };
        });
      },
      error: function(xhr, status, error) {
        console.error('데이터를 가져오는 중 오류가 발생했습니다:', error);
      }
    });
  } 

SetProductOptions();
SetMaterialOptions();

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
        type: 'option',
        label: '상품번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        component: 'jqxDropDownList',
        options:  prodoptions
    },
    {
    	name: 'materno',
        bind: 'materno',
        type: 'option',
        label: '재료번호',
        labelPosition: 'left',
        labelWidth: '30%',
        align: 'left',
        width: '250px',
        component: 'jqxDropDownList',
        options:  materoptions
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
