<?php
$file="3_sifat_orang_bertaqwa.pdf";
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
</head>
<body>
<div align="center">
    <?php
    $total_pages = 500;
    ?>
    <ul class="pagination">
        <li><a href="viewpdf.php?file=<?php echo $file; ?>&pNum=1">First</a></li>
        <li class="<?php if($pNum <= 1){ echo "disabled"; } ?>">
            <a href="<?php if($pNum <= 1){ echo "viewpdf.php?file=<?php echo $file; ?>&pNum=1"; } else { echo "viewpdf.php?file=$file&pNum=".($pNum - 1); } ?>">Prev</a>
        </li>
        <li class="<?php if($pNum >= $total_pages){ echo "disabled"; } ?>">
            <a target="_self" href="<?php if($pNum >= $total_pages){ echo "viewpdf.php?file=<?php echo $file; ?>&pNum=1"; } else { echo "viewpdf.php?file=$file&pNum=".($pNum + 1); } ?>">Next</a>
        </li>
        <li><a href="viewpdf.php?file=<?php echo $file; ?>&pNum=<?php echo $total_pages; ?>">Last</a></li>
    </ul>
    <?php
    ?>

    <br/>
    <canvas id="the-canvas" style="border:1px  solid black"></canvas>
</div>

<script src="http://blogchem.com/kasmui/dokumen/build/pdf.js"></script>

<script id="script">
    var url = "<?php echo $file; ?>";

    pdfjsLib.GlobalWorkerOptions.workerSrc =
        'http://blogchem.com/kasmui/dokumen/build/pdf.worker.js';

    var loadingTask = pdfjsLib.getDocument(url);
    loadingTask.promise.then(function(pdf) {

        pdf.getPage(<?php echo $pNum; ?>).then(function(page) {
            var scale = 1.5;
            var viewport = page.getViewport({ scale: scale, });

            var canvas = document.getElementById('the-canvas');
            var context = canvas.getContext('2d');
            canvas.height = viewport.height;
            canvas.width = viewport.width;

            var renderContext = {
                canvasContext: context,
                viewport: viewport,
            };
            page.render(renderContext);
        });
    });
</script>
</body>
</html>
