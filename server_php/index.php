<?php
require_once('Scores.php');

switch ($_GET['q']) {
    case 'get':
        $scores = Scores::getScores();
        foreach ($scores as $value) {
                    echo "$value[0], $value[1] <br>";
        }
        break;
    case 'set': Scores::setScore($_GET['name'], $_GET['score'], $_GET['hash']); break;
    case 'foo': echo('It works!'); break;
}	
?>