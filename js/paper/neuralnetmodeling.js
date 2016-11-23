
// Author URL: http://bikramkawan.com.np
// Email : bikramkawan@gmail.com
// Version: 18.03.2016


 var neuralinputs,hiddenlayer,featurenamex,featurenamey,neuraloutputs=[];
var neuralnetjson=[];
var neuralresult_actual=[],neuralresult_predicted=[],actualresult=[];
var  actualresultx=[], actualresulty=[];
var predictedresultx=[],predictedresulty=[];
var traintargets=[],trainout=[],testtargets=[],testout=[],traindateseries=[],testdateseries=[];
var neuralsname =[];
var neuralsnamey =[];
var neuralinputs1=[], neuraloutputs1=[];
$(document).ready(function(){


$('#neuralnetmodel').click(function () {
  neuralinputs=[];
  hiddenlayer ;
 neuraloutputs=[];
  var neuralnameinput=[], neuralnameoutput=[];
  //Read Inputs for Neural Net
  $('#inputs :selected').each(function(i, sel){ 

      neuralinputs.push(parseFloat($(sel).val()));
      neuralsname[i]=$(sel).text(); 
    //alert(neuralinputs);
 
  });


// Hidden Layer 

   hiddenlayer = parseFloat($('#hiddennet').val());


    //Read Output for Neural Net
  $('#outputs :selected').each(function(i, sel){ 
   neuraloutputs.push(parseFloat($(sel).val()));
  neuralsnamey[i]=$(sel).text(); 
  //alert(neuralsnamey);


  });

for (var i =0;i<neuralinputs.length; i++) {
    
  neuralnameinput.push(neuralsname[neuralinputs[i]-1]);
};

for (var i =0;i<neuraloutputs.length; i++) {
    
  neuralnameoutput.push(neuralsname[neuraloutputs[i]-1]);
};

    var nninputs = neuralnameinput;
   var hiddenlayer = $('#hiddenin').val();
   var nntarget =   neuralnameoutput;

   $.ajax({
      type: 'POST',
      url: 'ajaxhelper/neuralsetup.php',
      
      data: { nninputs: neuralnameinput, hiddenlayer: hiddenlayer , nntarget: neuralnameoutput},
      success: function(response) {

        alert("Inputs ="+neuralinputs+", Hidden ="+hiddenlayer+" Output="+neuraloutputs);
       
      $.colorbox({html:response,
         scrolling: false,
         preloading: false,});

      }
   });






});





//Read Data  Neural Networks 
$('#neuralnet').click(function () {

neuralinputs=[];
hiddenlayer=2;
neuraloutputs=[];
 // // Read Inputs for Neural Net
  $('#inputs :selected').each(function(i, sel){ 

   neuralinputs.push(parseFloat($(sel).val()));
	});


//Hidden Layer 

 hiddenlayer = parseFloat($('#hiddennet').val());


    //Read Output for Neural Net
  $('#outputs :selected').each(function(i, sel){ 

   neuraloutputs.push(parseFloat($(sel).val()));
	});


console.log(neuralinputs);
 console.log((hiddenlayer));
console.log(neuraloutputs);

    item = {}
        item ["neuralinputs"] = neuralinputs;
        item ["hiddenlayer"] = hiddenlayer;
        item ["neuraloutputs"] = neuraloutputs;

        neuralnetjson.push(item);

//alert(neuralnetjson);
//console.log(neuralnetjson);

//Ajax Call for Generating JSON and Matlab Call

   $(document).ajaxStart(function(){
        $("#wait").css("display", "block");
    });
    $(document).ajaxComplete(function(){
        $("#wait").css("display", "none");
    });
  $.ajax({
    
    url: 'Matlab/neuralnetmodel/generateneuralmodel.php',
   data:{ neuralnetjson: neuralnetjson},
    method:'GET',
   
    success: function (data) {
      // hide the "loading..." message
      alert("Neural Network Algortihm was Succesfully done by Matlab")
	


  
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


})  // End of Making neural net Modeling 


// Preparing for Plot
//Start
$('#nnresult').click(function () {

$.getJSON('Matlab/neuralnetmodel/neuraljsonObj.json', function (data) {
  neuralnetjson=data;
  console.log(neuralnetjson);
  neuraloutputs=neuralnetjson[0].neuraloutputs[0];

  console.log(data[0].neuraloutputs[0]);

});





  $.getJSON('Matlab/neuralnetmodel/neuralnetresult.json', function (data) {
  
console.log(data);
// console.log(data.neuralnetresult.testout[1])

for (var i = 0; i < data.neuralnetresult.traintargets.length; i++) {
    
  
  traintargets.push(data.neuralnetresult.traintargets[i]);
  trainout.push(data.neuralnetresult.trainout[i]);
    day=data.neuralnetresult.traindate[i].Day;
     month=data.neuralnetresult.traindate[i].Month;
     year= data.neuralnetresult.traindate[i].Year;
    traindateseries.push(year+"-"+month+"-"+day);
  
};

for (var i = 0; i < data.neuralnetresult.testout.length; i++) {
    
  
  testtargets.push(data.neuralnetresult.testtargets[i]);
  testout.push(data.neuralnetresult.testout[i]);
   day=data.neuralnetresult.testdate[i].Day;
     month=data.neuralnetresult.testdate[i].Month;
     year= data.neuralnetresult.testdate[i].Year;
    testdateseries.push(year+"-"+month+"-"+day);
  
};


console.log(neuralnetjson);

// console.log(typeof(actualresultx[0]));
// console.log(actualresulty);
featurenamex=neuralsname[neuralnetjson[0].neuraloutputs[0]-1];
featurenamey=neuralsnamey[neuralnetjson[0].neuraloutputs[0]-1];
console.log(featurenamex);
console.log(neuraloutputs);

data =[{
    x: traindateseries,
    y: traintargets,
     name: "Actual "+ featurenamex}];

    data1 =[{
    x: traindateseries,
    y: trainout,
    mode: 'lines',
    line: {
     dash: 'dot', 
    color: 'rgb(255, 0, 0)',
    width:2
  },
    name: "Predictive "+ featurenamex}];

data2 =[{
    x: testdateseries,
    y: testtargets,
     name: "Actual "+ featurenamex}];

    data3 =[{
    x: testdateseries,
    y: testout,
    mode: 'lines',
    line: {
     dash: 'dot', 
    color: 'rgb(255, 0, 0)',
    width:2
  },
    name: "Predictive "+ featurenamex}];




var layout = {

  showlegend: true,
  legend: {
    x: 0.5,
    y: 1
  },

  font: {
   
    size: 20
  },
  title: 'Training Data Set',
  xaxis: {
    title: 'Time Series'
  },
  yaxis: {
    title: featurenamey
  
  },
  
    width :800,
    height:500
  //margin: { t: 0 }
  
  };   



var layout1 = {

  showlegend: true,
  legend: {
    x: 0.5,
    y: 1
  },

  font: {
   
    size: 18
  },
  title: 'Testing Data Set',
  xaxis: {
    title: 'Time Series'
  },
  yaxis: {
    title: featurenamey
  
  },
  
    width :800,
    height:500
  //margin: { t: 0 }
  
  };  

Plotly.plot( 'chartarea', data,layout);
Plotly.plot( 'chartarea', data1,layout);
Plotly.plot( 'chartarea1', data2,layout1);
Plotly.plot( 'chartarea1', data3,layout1);

}); // End of AJAX Success Call 

});  ///End of PLot





})