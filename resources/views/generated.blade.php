<h3>Halo, User Baru Sudah Kamu Daftarkan</h3>

Daftar Usernya adalah: <br/>

<?php
$count=count($data);
$i=0;

while($i<$count)
    {
        echo "<b>".$data[$i]."</b>"."<br/>";
        $i++;
    }
?>
