
var featureid,featurename,decriptive_mode;
var decriptivemode_names=["Month","Year","Seasons"];


$(document).ready(function(){	

 $('#descft').change(function() {

    featurename=($(this).val());
    featureid = $(this).children(":selected").attr("id");

    //alert(featureid);
  });


 $('#mode').change(function() {

    //featurename=($(this).val());
    decriptive_mode = $(this).children(":selected").attr("id");
    //alert(decriptive_mode);
  });


 $('#calc_desc').click(function () {
if ( decriptive_mode==null||featureid==null)
{

   alert("You Need to Select Feature and mode");
 //  console.log(inputdata_ids+matlabscript+outputdata_ids);

}
else
{

   $(document).ajaxStart(function(){
    $("#wait").css("display", "block");
  });
   $(document).ajaxComplete(function(){
    $("#wait").css("display", "none");
  });
   $.ajax({

    url: 'Matlab/neuralnetmodel/generate_descmode.php',
    data:{ decriptive_mode: decriptive_mode,featureid:featureid},
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
}
 });



 $('#desresult').click(function () {
if ( decriptive_mode==null||featureid==null)
{

   alert("There is nothing to plot");
 //  console.log(inputdata_ids+matlabscript+outputdata_ids);

}
else
{



  var mean =[],median=[],mode=[],min=[],max=[],std=[],names=[],mode_freq=[],box=[];
  featureid=featureid-1;

  $.getJSON('Matlab/neuralnetmodel/desc_result.json', function (data) {

    console.log(data);
    //console.log(data.tmp[0].field1.length);
    //console.log(data.desc_result.seasons[0]);
    jsondata=data.desc_result;
    //console.log(jsondata.mean[1][1]);
    //console.log(jsondata.boxplotdata[0][0])
    for (var i = 0; i <jsondata.mean.length; i++) {

      mean.push(jsondata.mean[i][featureid]);
      median.push(jsondata.median[i][featureid]);
      mode.push(jsondata.mode[i][featureid]);

      min.push(jsondata.min[i][featureid]);

      max.push(jsondata.max[i][featureid]);

      std.push(jsondata.std[i][featureid]);
    
      if(decriptive_mode==1)
      {
        box=jsondata.boxplotdata;
        names.push(jsondata.months[i]);
      }

         if(decriptive_mode==2)
      {
        box=jsondata.boxplotdata;
        names.push(jsondata.years[i]);
      }

   if(decriptive_mode==3)
      {
        box.push(jsondata.boxplotdata[i][0]);
        names.push(jsondata.seasons[i]);
      }


      mode_freq.push("Frequency = "+jsondata.mod_freq[i][featureid])

};


// for (var i = 0; i < jsondata.boxplot.length; i++) {
    
// }

 //console.log(mean);
// console.log(median);
// console.log(mode);
// console.log(min);
// console.log(max);
// console.log(std);
// console.log(names);
// console.log( mode_freq);
//console.log(box[1]);

var mean_data = [
  {
    x: names,
    y: mean,
    type: 'bar'
  }
];

var layout = {
  title: 'Mean of '+ featurename + ' By '+ decriptivemode_names[decriptive_mode-1]
};

Plotly.newPlot('mean', mean_data,layout);

var median_data = [
  {
    x: names,
    y: median,
    type: 'bar'
  }
];

var layout = {
  title: 'Median of '+ featurename + ' By '+ decriptivemode_names[decriptive_mode-1]
};


Plotly.newPlot('median', median_data,layout);


var std_data = [
  {
    x: names,
    y: std,
    type: 'bar'
  }
];

var layout = {
  title: 'Standard Deviation of '+ featurename + ' By '+ decriptivemode_names[decriptive_mode-1]
};

Plotly.newPlot('std', std_data,layout);



var min_data = [
  {
    x: names,
    y: min,
    type: 'bar'
  }
];


var layout = {
  title: 'Minimum Value of '+ featurename + ' By '+ decriptivemode_names[decriptive_mode-1]
};


Plotly.newPlot('min', min_data,layout);

var max_data = [
  {
    x: names,
    y: max,
    type: 'bar'
  }
];

var layout = {
  title: 'Maximum Value of '+ featurename + ' By '+ decriptivemode_names[decriptive_mode-1]
};

Plotly.newPlot('max', max_data,layout);



var mode_data = [
  {
    x: names,
    y: mode,
    type: 'bar',
    text:mode_freq
  }
];

var layout = {
  title: 'Mode of '+ featurename + ' By '+ decriptivemode_names[decriptive_mode-1]
};



Plotly.newPlot('mode1', mode_data,layout);

//console.log(mode_data);


var box_data=[];
console.log(box);
if (decriptive_mode!=3) {

var trace1 = {
    y: box,
    type: 'box',
     name: 'Wiskers and Outliers',
  marker: {
    color: 'rgb(107,174,214)'
  },
  boxpoints: 'Outliers'

  };
// var trace5 = {
//     y: box[1],
//     type: 'box',
//      name: 'Wiskers and Outliers',
//   marker: {
//     color: 'rgb(107,174,214)'
//   },
//   boxpoints: 'Outliers'

//   };

box_data=[trace1]
console.log(box_data);

var layout = {
  title: 'Box Plot of '+ featurename + ' By '+ decriptivemode_names[decriptive_mode-1]
};

Plotly.newPlot('box1', box_data,layout);
//console.log(box_data);

}
if (decriptive_mode==3) {

var trace1 = {
    y: box[0],// This is Spring i.e. Season =1 
    type: 'box',
     name: 'Spring',
  marker: {
    color: 'rgb(107,174,214)'
  },
  boxpoints: 'Outliers'

  };
var trace2 = {
    y: box[0],// This is Summer i.e. Season =2 
    type: 'box',
     name: 'Summer',
  marker: {
    color: 'rgb(107,174,214)'
  },
  xaxis: 'x2',
  yaxis: 'y2',
  boxpoints: 'Outliers'

  };
  var trace3 = {
    y: box[0],// This is Autumn i.e. Season =3
    type: 'box',
     name: 'Autumn',
  marker: {
    color: 'rgb(107,174,214)'
  },
   xaxis: 'x3',
  yaxis: 'y3',
  boxpoints: 'Outliers'

  };
  var trace4 = {
    y: box[0],// This is Winter i.e. Season =4 
    type: 'box',
     name: 'Winter',
  marker: {
    color: 'rgb(107,174,214)'
  },
  xaxis: 'x4',
  yaxis: 'y4',
  boxpoints: 'Outliers'

  };

box_data=[trace1,trace2,trace3,trace4];
console.log(box_data);

var layout = {
  title: 'Box Plot of '+ featurename + ' By '+ decriptivemode_names[decriptive_mode-1],
  xaxis: {domain: [0, 0.45]},
  yaxis: {domain: [0, 0.45]},
  xaxis4: {
    domain: [0.55, 1],
    anchor: 'y4'
  },
  xaxis3: {
    domain: [0, 0.45],
    anchor: 'y3'
  },
  xaxis2: {domain: [0.55, 1]},
  yaxis2: {
    domain: [0, 0.45],
    anchor: 'x2'
  },
  yaxis3: {domain: [0.55, 1]},
  yaxis4: {
    domain: [0.55, 1],
    anchor: 'x4'
  },
  height: 800
  //width: 600
};

Plotly.newPlot('box1', box_data,layout);
//console.log(box_data);

}
});
}

});









});