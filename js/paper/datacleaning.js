
// Author URL: http://bikramkawan.com.np
// Email : bikramkawan@gmail.com
// Version: 18.03.2016

 

 var cleaningid ;
   var xval=[];
var yval=[]; 
var rawvalue=[];
var cleanvalue=[];
var timeseries=[];
var dateseries=[]; 

  $(document).ready(function(){
$('#dataclean').change(function() {
    attribute=($(this).val());
 cleaningid = $(this).children(":selected").attr("id");
   alert("You have selected Phase shifting Correction");


});
  

     $(document).ajaxStart(function(){
        $("#wait").css("display", "block");
    });
    $(document).ajaxComplete(function(){
        $("#wait").css("display", "none");
    });
  $('#cleaning').click(function() {

  
  $.ajax({
    
    url: 'Matlab/dataclean/generatedatacleaning.php',
   data:{ cleaningid: cleaningid},
    method:'GET',
   
    success: function (data) {
      // hide the "loading..." message
      alert("Data Cleaning was Succesfully done by Matlab")
	var array  = JSON.parse(data);


//   console.log(array.heading.length);
//   console.log(array.heading[0][1]);
//         for (var i = 0; i <array.length; i++) {
    
    
//   parseFloat(xval.push(array[i].0));
//   parseFloat(yval.push(array[i].0));


   
// };
// console.log(xval);
// console.log(yval);
	
    
    },
    error: function (err) {
      console.log('Error', err);
      if (err.status === 0) {
        alert('Failed to load data/basic.json.\nPlease run this example on a server.');
      }
      else {
        alert('Failed to load data/basic.json.');
      }
    }
  });

  });


$('#featureattr').change(function() {
    attribute1=($(this).val());
    alert(attribute1);
 featureattr = $(this).children(":selected").attr("id");
   //alert("Y Correction"+featureattr);


});
  


///Plot for Heading Before Correction and After Correction
$('#termotol').click(function () {
 

  $.ajax({
    url:'Matlab/dataclean/cleandata.json',
    type:'HEAD',
    error: function()
    {
        //file not exists
    alert("Matlab is processing cleandata Data");
    },
    success: function()
    {
         alert("Matlab successfully generates cleandata Data");
    }
});


//  var f = [];
// for(var i = 0; i < 2; i++) {
//   f.push([]);
//   for( var j = 0; j < 2; j++) {
//     f[i].push(6);
//   } 
// }
// console.log(f);


  $.getJSON('Matlab/dataclean/cleandata.json', function (data) {
   //console.log(data);
    //console.log((parseFloat(data.cleandata.rawdata[7][0])))
     
    // console.log(((data.cleandata.dateseries[0].Day)++))

  //console.log(data.cleandata.rawdata.length); //console.log("'"+year+"-"+month+"-"+day+"'");
for (var i = 0; i <data.cleandata.rawdata.length; i++) {

  rawvalue.push([]);
  cleanvalue.push([]);

    for (var j = 0; j <data.cleandata.rawdata[0].length; j++) { 
   // console.log((parseFloat(data.cleandata.rawdata[i][j])))

  rawvalue[i].push(parseFloat(data.cleandata.rawdata[i][j]));
  cleanvalue[i].push(parseFloat(data.cleandata.cleandata[i][j]));
 
}
   
};
for (var j = 0; j <data.cleandata.dateseries.length; j++) { 

 
    day=data.cleandata.dateseries[j].Day;
     month=data.cleandata.dateseries[j].Month;
     year= data.cleandata.dateseries[j].Year;
    dateseries.push(year+"-"+month+"-"+day);
};


  //console.log((rawvalue[featureattr]));
  //console.log(cleanvalue);
  //console.log(timeseries);
 //  console.log(cleanvalue);
  //console.log(dateseries);
TESTER = document.getElementById('rawdatadiv');

data ={
    x: dateseries,
    y: rawvalue[featureattr],
     name: attribute1+" with Missing Data",
     mode: 'lines'

 
   };


    data1 ={
    x: dateseries,
    y: cleanvalue[featureattr],
    mode: 'lines',

    line: {
     dash: 'dot', 
    color: 'rgb(255, 0, 0)',
    width:2
  },
    name: attribute1+ " after filling Missing Data"};

var layout = {
   showlegend: true,
  legend: {
    x: 0.5,
    y: 1
  },

  font: {
   
    size: 25
  },
  xaxis: {
    title: 'Timeseries'
   
  },
  yaxis: {
    title: attribute1,
 
  
  },
  
    width :1000,
    height:800,
  margin: { t: 0 }
  
  
  
};   

var dataset=[data,data1];
console.log(data1);
Plotly.newPlot(TESTER, dataset,layout);
//Plotly.newPlot( TESTER, data1,layout);





  });
});







});



