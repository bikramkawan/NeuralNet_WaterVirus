
  // Author URL: http://bikramkawan.com.np
  // Email : bikramkawan@gmail.com
  // Version: 18.03.2016



  var Rval=[];
  var Pval=[];
  var corval_Y=[];
  var ylabel;
  var corrindex_X=[];
  var Rval1_y=[],Pval1_y=[],Rval2_y=[],Pval2_y=[],Rval3_y=[],Pval3_y=[],Rval4_y=[],Pval4_y=[],Rval5_y=[],Pval5_y=[];
  var Rval6_y=[],Pval6_y=[],Rval7_y=[],Pval7_y=[],Rval8_y=[],Pval8_y=[],Rval9_y=[],Pval9_y=[],Rval10_y=[],Pval10_y=[];
  var yval2=[];
  var xvalues=[];
  var index_xvalue=[];

  $(document).ready(function(){


  //Block for Generating JSON Data
  $(document).ajaxStart(function(){
    $("#wait").css("display", "block");
  });
  $(document).ajaxComplete(function(){
    $("#wait").css("display", "none");
  });

  $('#generatecorrdata').click(function() {



    $.ajax({
      
      url: 'Matlab/correlation/generatecorrdata.php',
      data:{ cleaningid: cleaningid},
      method:'GET',
      
      success: function (data) {
        // hide the "loading..." message
        alert("Correlation Process was successfully done by Matlab")
        
        
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

  //Block For preparation for selecting variables to show correlation data.

  $('#corrx').change(function() {
    attribute=($(this).val());

    corval_Y = $(this).children(":selected").attr("id");

  //console.log(corval_Y);


});


  //Block For Plot Bar Chart

  $('#corrbar').click(function () {


    //Block for Muliple Parameters Filterd
    $('#multiple :selected').each(function(i, sel){ 

     //console.log( $(sel).val()); 
     corrindex_X.push(parseFloat($(sel).val()));
      //alert(corrindex_X);
      xvalues[i]=$(sel).text(); 
     // alert(xvalues);
   });



    $.ajax({
      url:'Matlab/correlation/corrdata.json',
      type:'HEAD',
      error: function()
      {
          //file not exists
          alert("Matlab is processing Correlation Data");
        },
        success: function()
        {
         alert("Matlab successfully generates Correlation Data");
       }
     });
   //Plot for Bar Chart Continues
   $.getJSON('Matlab/correlation/corrdata.json', function (data) {
    
     console.log(data);
     // console.log(data.corrdata.R[0][9])

     for (var i = 0; i <data.corrdata.P.length; i++) {

      Rval.push([]);
      Pval.push([]);

      for (var j = 0; j <data.corrdata.P.length; j++)

      {

        Rval[i].push((data.corrdata.R[i][j]));
        Pval[i].push((data.corrdata.P[i][j]));
      }

    };

    console.log(Rval[corval_Y-1]);
    

    console.log(corrindex_X);

    var plotdatay1=[],plotdatay2=[],index_xvalue=[];

    for (var k = 0; k <corrindex_X.length; k++)
    {
      Rval1_y.push(Rval[corval_Y-1][corrindex_X[k]]); 
      Pval1_y.push(Pval[corval_Y-1][corrindex_X[k]]); 
      index_xvalue.push(xvalues[k]);  }

      
      plotdatay1 = Rval1_y;      plotdatay2 = Pval1_y;  
      
      ylabel =attribute ; 

  //alert(ylabel);
  

  console.log(plotdatay1);
  console.log(plotdatay2);
  //Plot Function Data Starts here
  var R = {
    x: index_xvalue,
    y: plotdatay1,
    name: 'R',
    type: 'bar'
  };

  var P = {
    x: index_xvalue,
    y: plotdatay2,
    name: 'P',
    type: 'bar'
  };

  var data = [R, P];

  var layout = {yaxis: 
    {title: ylabel},
    barmode: 'group'};


    Plotly.newPlot('corrchartarea', data,layout);


  });

 });






});
