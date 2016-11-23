
// Author URL: http://bikramkawan.com.np
// Email : bikramkawan@gmail.com
// Version: 18.03.2016


 var inputdata_ids=[],featurenamex,featurenamey,outputdata_ids=[];
var neuralnetjson=[];
var neuralresult_actual=[],neuralresult_predicted=[],actualresult=[];
var  actualresultx=[], actualresulty=[];
var predictedresultx=[],predictedresulty=[];
var traintargets=[],trainout=[],testtargets=[],testout=[],traindateseries=[],testdateseries=[];
var neuralsname =[];
var neuralsnamey =[];
var inputdata_ids1=[], outputdata_ids1=[];
var modelingname,modelingtype;
var modelingid;
var neuralnameinput=[], neuralnameoutput=[];
var yraw=[],yreg=[],timeseries=[];
var listofmodels=[];
var matlabscript;
$(document).ready(function(){


   $('#modeling').change(function() {
    modelingid=($(this).val());
 // modelingid = $(this).children(":selected").attr("id");
  // alert(modelingid);


   $.getJSON('Matlab/models/listofmodels.json', function (data) {

    //console.log(data[0].matlabscriptname[modelingid]);
    matlabscript=data[0].matlabscriptname[modelingid];
// if (matlabscript=="WaterNN.m")

//    {

//     alert("heyylll");
//    }

   });

   





});




//Read Data  Neural Networks 
$('#neuralnet').click(function () {
  inputdata_ids=[];

outputdata_ids=[];
 // // Read Inputs for Neural Net
  $('#inputs :selected').each(function(i, sel){ 

   inputdata_ids.push(parseFloat($(sel).val()));
    neuralsname[i]=$(sel).text(); 
  });






    //Read Output for Neural Net
  $('#outputs :selected').each(function(i, sel){ 

   outputdata_ids.push(parseFloat($(sel).val()));
   neuralsnamey[i]=$(sel).text(); 
  });

if ( inputdata_ids.length<1||matlabscript==null||outputdata_ids.length<1)
{

   alert("You Need to Select Inputs, Modeling and Output First");
   console.log(inputdata_ids+matlabscript+outputdata_ids);

}

else{

  




console.log(inputdata_ids);
 console.log(modelingid);
console.log(outputdata_ids);
console.log(neuralsnamey);

    item = {}
        item ["inputdata_ids"] = inputdata_ids;
        item ["modelingid"] = modelingid;
        item ["outputdata_ids"] = outputdata_ids;

        neuralnetjson.push(item);

//alert(neuralnetjson);
console.log(neuralnetjson);




//Ajax Call for Generating JSON and Matlab Call

   $(document).ajaxStart(function(){
        $("#wait").css("display", "block");
    });
    $(document).ajaxComplete(function(){
        $("#wait").css("display", "none");
    });
  $.ajax({
    
    url: 'Matlab/neuralnetmodel/generateneuralmodel.php',
   data:{ neuralnetjson: neuralnetjson,modelingid:modelingid,listofmodels:listofmodels},
    method:'GET',
   
    success: function (data) {
      // hide the "loading..." message
      alert("Modeling was Succesfully done by Matlab")
	  // alert(data);


  
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
}

})  // End of Making neural net Modeling 


// Preparing for Plot
//Start
$('#nnresult').click(function () {

if ( matlabscript==null)

 {
       alert("You need to Select Inputs, Modeling Method and Output");
                        
  }




else  
{


      if (matlabscript=="WaterNN.m") 
      {
        //alert(matlabscript+"plot");

                          $.getJSON('Matlab/neuralnetmodel/neuraljsonObj.json', function (data) {
                            neuralnetjson=data;
                            console.log(neuralnetjson);
                            outputdata_ids=neuralnetjson[0].outputdata_ids[0];

                            console.log(data[0].outputdata_ids[0]);

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
                          featurenamex=neuralsname[neuralnetjson[0].outputdata_ids[0]-1];
                          featurenamey=neuralsnamey[neuralnetjson[0].outputdata_ids[0]-1];

                                        console.log(featurenamex);
                          
                          if (featurenamex==null)
                          {
                            alert("First You need to run Modeling to Plot Results")
                          }
                          else
                          {


                                        //console.log(outputdata_ids);

                                        console.log(featurenamex);

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
                            }
                          }); // End of AJAX Success Call 

                        
        }            

      else  
        {
 
                               $.getJSON('Matlab/neuralnetmodel/neuraljsonObj.json', function (data) {
                                  neuralnetjson=data;
                                  console.log(neuralnetjson);
                                  outputdata_ids=neuralnetjson[0].outputdata_ids[0];

                                  console.log(data[0].outputdata_ids[0]);

                                });

                                $.getJSON('Matlab/neuralnetmodel/modelingresults.json', function (data) {
                                  
                                console.log(data);

                                for (var i = 0; i < data.modelingresults.timeseries.length; i++) {
                                    
                                  
                                  yraw.push(data.modelingresults.yraw[i]);
                                  yreg.push(data.modelingresults.yreg[i]);
                                    day=data.modelingresults.timeseries[i].Day;
                                     month=data.modelingresults.timeseries[i].Month;
                                     year= data.modelingresults.timeseries[i].Year;
                                    timeseries.push(year+"-"+month+"-"+day);
                                  
                                };

                                // console.log(yraw);
                                // console.log(yreg);
                                // console.log(timeseries);

                                featurenamex=neuralsname[neuralnetjson[0].outputdata_ids[0]-1];
                                featurenamey=neuralsnamey[neuralnetjson[0].outputdata_ids[0]-1];

                                if (featurenamex==null)
                                
                                {
                                  alert("First You need to run Modeling to Plot Results")
                                }

                                else 
                                {  

                                              data =[{
                                                  x: timeseries,
                                                  y: yraw,
                                                   name: "Actual "+ featurenamex}];

                                                  data1 =[{
                                                  x: timeseries,
                                                  y: yreg,
                                                  mode: 'lines',
                                                  line: {
                                                   dash: 'dot', 
                                                  color: 'rgb(255, 0, 0)',
                                                  width:2
                                                },
                                                  name: "Predicted "+ featurenamex}];



                                              var layout = {

                                                showlegend: true,
                                                legend: {
                                                  x: 0.5,
                                                  y: 1
                                                },

                                                font: {
                                                 
                                                  size: 20
                                                },
                                                title: 'Yraw vs Yreg',
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

                                     }         

                                });

        // }

          }


}



});  ///End of PLot





})