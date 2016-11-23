
var matlabscriptname=[];
var nameofmodel=[];
var listofmodels=[];

$(document).ready(function(){	

 $.getJSON('Matlab/models/listofmodels.json', function (data) {

  console.log(data)

  for (var i = 0; i < data[0].matlabscriptname.length; i++) {
    
   matlabscriptname.push(data[0].matlabscriptname[i]);   
   nameofmodel.push(data[0].nameofmodel[i])	
   
 };



});
 $('#addmodel').change(function() {
  modelingname=($(this).val());
  
     //alert(modelingname);
     matlabscriptname.splice([modelingname],1);
     nameofmodel.splice([modelingname],1);

   });


 $('#deletemodel').on('click', function() {
  
  listofmodels=[];


  item1 = {}
  item1["nameofmodel"] = nameofmodel;
  
  item1["matlabscriptname"] = matlabscriptname;
  

  listofmodels.push(item1);

  //alert(matlabscriptname);

  console.log(listofmodels);

  console.log(item1);
  console.log(listofmodels[0].matlabscriptname);

  $.ajax({
    
    url: 'Matlab/models/generatemodels.php',
    data:{ listofmodels:listofmodels},
    method:'GET',
    
    success: function (data) {
        // hide the "loading..." message
        alert("JSON file was Succesfully created")
  	   //alert(data);


      
    },
    error: function (err) {
      console.log('Error', err);
      if (err.status === 0) {
        alert('Failed to load json.\nPlease run this example on a server.');
      }
      else {
        alert('Failed to load json.');
      }
    }
  });


  console.log(matlabscriptname);

});



 $('#upload').on('click', function() {

   console.log(matlabscriptname);
   var file_data = $('#sortpicture').prop('files')[0];  
      //alert($('#sortpicture')[0].files[0].name); 
      matlabscriptname.push($('#sortpicture')[0].files[0].name);

      var form_data = new FormData();                  
      form_data.append('file', file_data);
      //alert(file_data);                             
      $.ajax({
                  url: 'Matlab/models/generateneuralmodel.php', // point to server-side PHP script 
                  dataType: 'text',  // what to expect back from the PHP script, if anything
                  cache: false,
                  contentType: false,
                  processData: false,
                  data: form_data,                         
                  type: 'post',
                  success: function(php_script_response){
                    alert("Uploaded Sucessfully");
                    
                      //alert(matlabscriptname);
                       // display response from the PHP script, if any
                     }
                   });



      nameofmodel.push($("#modelname").val());
  // nameofmodel.push("Bikram");
  // matlabscriptname.push("back.m");



  item1 = {}
  item1["nameofmodel"] = nameofmodel;
  
  item1["matlabscriptname"] = matlabscriptname;
  

  listofmodels.push(item1);

  //alert(matlabscriptname);
  console.log(listofmodels);

  

  $.ajax({
    
    url: 'Matlab/models/generatemodels.php',
    data:{ listofmodels:listofmodels},
    method:'GET',
    
    success: function (data) {
        // hide the "loading..." message
        alert("JSON file was Succesfully created")
  	   //alert(data);


      
    },
    error: function (err) {
      console.log('Error', err);
      if (err.status === 0) {
        alert('Failed to load json.\nPlease run this example on a server.');
      }
      else {
        alert('Failed to load json.');
      }
    }
  });

});


 $('#uploaddata').on('click', function() {

  	//console.log(matlabscriptname);
    var file_data = $('#updata').prop('files')[0];  
      //alert($('#sortpicture')[0].files[0].name); 
      matlabscriptname.push($('#updata')[0].files[0].name);

      var form_data = new FormData();                  
      form_data.append('file', file_data);
      //alert(file_data);                             
      $.ajax({
                  url: 'generateneuralmodel.php', // point to server-side PHP script 
                  dataType: 'text',  // what to expect back from the PHP script, if anything
                  cache: false,
                  contentType: false,
                  processData: false,
                  data: form_data,                         
                  type: 'post',
                  success: function(php_script_response){
                    alert("Uploaded Sucessfully");
                    
                      //alert(matlabscriptname);
                       // display response from the PHP script, if any
                     }
                   });

    });




  //Ajax Call for Generating JSON and Matlab Call



});