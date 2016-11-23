<!--
Author URL: http://bikramkawan.com.np
Email : bikramkawan@gmail.com
Version: 18.03.2016
-->
<html>
  <head>
    <script type="text/javascript">
      // Javascript function which takes care for multiple uploads
      var attachmentlimit = 5; // Limiting maximum uploads to 5
      var attachid = 2;
      function attachmore() { // Function is called when user presses Attach Another File
        attachid += 1;
        document.getElementById('attachmentdiv').innerHTML += '<div id="attachdiv_' + attachid + '" style="margin-top:5px"><input type="file" id="attach_' + attachid + '" name="attach_' + attachid + '" size="30" onchange="document.uploadattach.submit();"/></div>';
        //alert("attach_"  );
        if(attachid == attachmentlimit) {
          document.getElementById('addanother').style.display='none';
        }
      }
    </script>
  </head>
  <body>
    <div style="margin-left:10px">
   
    </div>
    <!-- Form taking care of the uploads, notice that the frame target is the iframe contained inside, to which it fires upload.php -->
    <form id="uploadattach" enctype="multipart/form-data" name="uploadattach" target="attachmentiframe" action="uploadmodel.php" method="post">
      <div id="attachmentdiv" style="margin-left:30px">
        <iframe name="attachmentiframe" style="display:none"></iframe>
        <div id="attachdiv_1" style="margin-top:5px">
            <input type="file" id="attach_1" name="attach_1" size="30" onchange="document.uploadattach.submit();"/>
        </div>
      </div>
      <!-- div showing error message for invalid file type -->
      <div id="typeerrormessage" style="display:none;margin-left:30px">
        <font color=#990000 size=1>Only png, jpg and gif file type are supported</font>
      </div>
      <!-- div showing error message for exceeded file size -->
      <div id="sizeerrormessage" style="display:none;margin-left:30px">
        <font color=#990000 size=1>File exceeded maximum allowed limit of 100 Kb</font>
      </div>
      <div id="addanother" style="margin-left:30px;margin-top:5px">
        <a href="javascript:void(0)" onclick="attachmore();"><font size=2>Attach another file</font></a>
      </div>
      <div> <?php 
      $i=1;

      $attachments = 'attach_'.$i;
    $attachmentdiv = 'attachdiv_'.$i;
    $FileName = $_FILES[$attachments]['name']; ?> </div>
    </form>
  </body>
</html>
