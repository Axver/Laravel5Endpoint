<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script src="{!! asset('build/pdf.js') !!}"></script>
    <script src="{!! asset('build/pdf.worker.js') !!}"></script>
    <title>PDF Viewer</title>
</head>
<body>

<input type="hidden" id="nama" value="<?php echo $nama; ?>">
<div align="center">
    <br/>
    <canvas id="the-canvas"></canvas>
</div>

<script>

        let nama=document.getElementById('nama').value;

        // If absolute URL from the remote server is provided, configure the CORS
        // header on that server.
        var url = nama;

        // Loaded via <script> tag, create shortcut to access PDF.js exports.
        var pdfjsLib = window['pdfjs-dist/build/pdf'];

        // The workerSrc property shall be specified.
        pdfjsLib.GlobalWorkerOptions.workerSrc = '//mozilla.github.io/pdf.js/build/pdf.worker.js';

        // Asynchronous download of PDF
        var loadingTask = pdfjsLib.getDocument(url);
        loadingTask.promise.then(function(pdf) {
            console.log('PDF loaded');

            // Fetch the first page
            var pageNumber = 1;
            pdf.getPage(pageNumber).then(function(page) {
                console.log('Page loaded');

                var scale = 1.5;
                var viewport = page.getViewport({scale: scale});

                // Prepare canvas using PDF page dimensions
                var canvas = document.getElementById('the-canvas');
                var context = canvas.getContext('2d');
                canvas.height = viewport.height;
                canvas.width = viewport.width;

                // Render PDF page into canvas context
                var renderContext = {
                    canvasContext: context,
                    viewport: viewport
                };
                var renderTask = page.render(renderContext);
                renderTask.promise.then(function () {
                    console.log('Page rendered');
                });
            });
        }, function (reason) {
            // PDF loading error
            console.error(reason);
        });

</script>
</body>
</html>
