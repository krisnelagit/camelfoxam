// JavaScript Document
//This function is used for confirmation 
function confirmation(message,hiddenID){   
    var answer = confirm(message)
    
    if (answer){ 
document.getElementById(hiddenID).value = "Yes";
return true;
    }
    else{
    document.getElementById(hiddenID).value = "No";
    return false; 
    }  
}
//End

//This function is used for not move to previous page by pressing back button of browser
//window.history.forward();
//function noBack(){window.history.forward();}//if u use this, u have to call it in onload of body tag [onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload=""]
//End'

//Allow numbers only 
function isNumberKey(evt)
{
    
    var charCode = (evt.which) ? evt.which : event.keyCode;
    
    if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode !== 8) 
     return false;
     return true;     
     
}
//Allow only delete and back space
function isDeleteBackButton(evt)
{
    
    var charCode = (evt.which) ? evt.which : event.keyCode
    
    if (charCode !=127 && charCode!=8) 
     return false;
     return true;     
     
}


//Allow numbers only with dot 
function isDecimal(evt)
{
    
    var charCode = (evt.which) ? evt.which : event.keyCode
    
    if (charCode > 31 && (charCode < 46 || charCode > 57) && charCode != 8) 
     return false;
     return true;     
     
}
/////////////////////// is Decimal
 
//////////////////

//Allow Text only
    function isTextKey(evt)
{
    var charCode = (evt.which) ? evt.which : event.keyCode;
   
    if (charCode > 31 && (charCode < 48 || charCode > 57) || charCode === 8) 
     return true;  
     return false;
        
     
}

//Not allow to type
function isEntry(evt)
{    return false;       
     
}

//this code is used for check all check boxes in gridview or datalist 
 function checkunchkall(item,controlname)
    {
  
// alert("sdfgsd");
        if (item.checked==true)
        {
        
            var dc=document.getElementById(controlname);
        
                var oInput=dc.getElementsByTagName("input");
               
                for (var i=0;i<oInput.length;i++)
                {
                    if (oInput[i].type.toLowerCase()=="checkbox")
                    {
                        oInput[i].checked=true;
                    }
                }
        }
        else
        {
            var dc1=document.getElementById(controlname);
          
                var oInput1=dc1.getElementsByTagName("input");
                for (var j=0;j<oInput1.length;j++)
                {
                if (oInput1[j].type.toLowerCase()=="checkbox")
                {
                oInput1[j].checked=false;
                }
                }
        }
    }
    
    //other way of  check all check boxes in gridview or datalist 
        function SelectAllCheckboxes(spanChk){

   // Added as ASPX uses SPAN for checkbox
   var oItem = spanChk.children;
   var theBox= (spanChk.type=="checkbox") ? 
        spanChk : spanChk.children.item[0];
   xState=theBox.checked;
   elm=theBox.form.elements;

   for(i=0;i<elm.length;i++)
     if(elm[i].type=="checkbox" && 
              elm[i].id!=theBox.id)
     {
       //elm[i].click();
       if(elm[i].checked!=xState)
         elm[i].click();
       //elm[i].checked=xState;
     }
 }
    // End this code is used for check all check boxes in gridview or datalist 
    
    //this code is used change text box css on focus
    
     function OnTextCursor1(control)
    {
    
    document.getElementById(control.id).className="ClassRound1";
   
    
    }
    function OnTextBlur1(control)
    {
     document.getElementById(control.id).className="ClassRound";
    
    }
    
   // Not Allow to Entry
function isEntry(evt)
{
return false;         
}


  function DeductDeposit()
{
document.getElementById("ctl00_ContentPlaceHolder1_lbDeductDeposit").innerHTML=document.getElementById("ctl00_ContentPlaceHolder1_txtPayAmount").innerHTML
var txtPayAmount=0;
var txtPayamtinHand=0;
 txtPayAmount=document.getElementById("ctl00_ContentPlaceHolder1_txtPayAmount").value;
 txtPayamtinHand=document.getElementById("ctl00_ContentPlaceHolder1_txtPayamtinHand").value;
 var total=txtPayAmount - txtPayamtinHand;
document.getElementById("ctl00_ContentPlaceHolder1_lbDeductDeposit").innerHTML=total;
}  
 
 function txtboxDefaultValue(textBoxId)
  {  
 var textBox=document.getElementById(textBoxId).value; 
 if (textBox.length<=0)
  { 
  document.getElementById(textBoxId).value='0';   
  }
 
  }
       
   
 
function onCalendarShown() {
   var cal = $find("calendar1");
   cal._switchMode("years", true); 
   if (cal._yearsBody) {
      for (var i = 0; i < cal._yearsBody.rows.length; i++) {
         var row = cal._yearsBody.rows[i];
         for (var j = 0; j < row.cells.length; j++) {
             Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
         }
        }
      }
   }

function onCalendarHidden() {
  var cal = $find("calendar1");
  if (cal._yearsBody) {
     for (var i = 0; i < cal._yearsBody.rows.length; i++) {
        var row = cal._yearsBody.rows[i];
        for (var j = 0; j < row.cells.length; j++) {
           Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
        }
     }
    }
}

function call(eventElement) {
   var target = eventElement.target;
   switch (target.mode) {
       case "year":
        var cal = $find("calendar1");
       cal.set_selectedDate(target.date);
       cal._blur.post(true);
       cal.raiseDateSelectionChanged(); break;
  }
}


    
    

 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
      //end this code is used change text box css on focus
      
      //gridview radio buttons 
      //One problem when using radio buttons is all the radio buttons will be selected. So for getting only a single radio button selected, use the following script:
//     function RadioCheck(rb) {
//        var gv = document.getElementById("<%=grdSource.ClientID%>");
//        var rbs = gv.getElementsByTagName("input");
//        var row = rb.parentNode.parentNode;
//        for (var i = 0; i < rbs.length; i++) {
//            if (rbs[i].type == "radio") {
//                if (rbs[i].checked && rbs[i] != rb) {
//                    rbs[i].checked = false;
//                    break;
//                }
//            }
//        }
//        }
        //end gridview radio buttons 

 