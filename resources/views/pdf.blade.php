<?php
$file=$nama;
$pNum=1;
?>
        <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PDF Viewer</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script language=JavaScript>
        <!--

        //Disable right mouse click Script
        //By Maximus (maximus@nsimail.com) w/ mods by DynamicDrive
        //For full source code, visit http://www.dynamicdrive.com

        var message="Function Disabled!";

        ///////////////////////////////////
        function clickIE4(){
            if (event.button==2){
                alert(message);
                return false;
            }
        }

        function clickNS4(e){
            if (document.layers||document.getElementById&&!document.all){
                if (e.which==2||e.which==3){
                    alert(message);
                    return false;
                }
            }
        }

        if (document.layers){
            document.captureEvents(Event.MOUSEDOWN);
            document.onmousedown=clickNS4;
        }
        else if (document.all&&!document.getElementById){
            document.onmousedown=clickIE4;
        }

        document.oncontextmenu=new Function("alert(message);return false")

        // -->
    </script>

    <style>
        .num{
            font-size: 30px;
        }
    </style>
</head>
<body>
<div align="center">
    <input type="hidden" id="name" value="<?php echo $nama?>">


    <br/>
    <div id="conx">

    </div>

</div>

<script src="http://blogchem.com/kasmui/dokumen/build/pdf.js"></script>

<script id="script">
    var url = "<?php echo $file; ?>";

    pdfjsLib.GlobalWorkerOptions.workerSrc =
        'http://blogchem.com/kasmui/dokumen/build/pdf.worker.js';

    var loadingTask = pdfjsLib.getDocument(url);
    loadingTask.promise.then(function(pdf) {
        // console.log(page);
        var numPages = pdf.numPages;
        console.log(numPages);
        //Generate auto canvas
        let i=0;
        while(i<numPages)
        {
            //Create new element
            let canvas = document.createElement('canvas');
            let divx=document.createElement('div');

                div = document.getElementById('conx');

            $(canvas).attr('id', i+"a");
            $(divx).attr('id', i+"b");
            $(divx).attr('class', "num");

            canvas=div.appendChild(canvas);
            divx=div.appendChild(divx);



            console.log(canvas);

            pdf.getPage(i).then(function(page) {
                var scale = 1.5;
                var viewport = page.getViewport({ scale: scale, });
                let hm="";

                console.log(hm.concat(i,'a'));
                let mj=hm.concat(i,'a');
                var canvas1 = canvas;
                console.log(canvas1)
                var context = canvas1.getContext('2d');
                canvas1.height = viewport.height;
                canvas1.width = viewport.width;

                var renderContext = {
                    canvasContext: context,
                    viewport: viewport,
                };
                page.render(renderContext);


            });

            console.log($("#"+i+"b")[0].innerText=i+1);




            i++;
        }










    });
</script>
</body>
</html>
