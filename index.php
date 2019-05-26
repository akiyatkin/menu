<?php

use infrajs\ans\Ans;
use infrajs\load\Load;
use infrajs\excel\Xlsx;

$name = Ans::get('name','string','Главное меню');
$src = Ans::get('src','string','~pages/Параметры.xlsx');


$list = Load::loadJSON('-excel/get/group/'.$name.'/?src='.$src);


if (isset($list['data']['data'])) $list = $list['data']['data'];
else $list = array();

$prev = array('Уровень' => false);
$ans = &$prev;
$levels = [];
foreach ($list as $i => &$row) {
	if ($row['Уровень'] < $prev['Уровень']) {
		$row['parent'] = &$prev['parent']['parent'];
	} else if ($row['Уровень'] > $prev['Уровень']) {
		$row['parent'] = &$prev;
	} else if ($row['Уровень'] == $prev['Уровень']) {
		//1, 1 - вложенный в prev['parent']
		$row['parent'] = &$prev['parent'];
	}
	if (!isset($row['parent']['childs'])) $row['parent']['childs'] = [];
	$row['parent']['childs'][] = &$row;
	
	$levels[$row['Уровень']] = true;
	$prev = &$row;
	
}

Xlsx::runGroups($ans, function &(&$group){
	unset($group['parent']);
	$r = null;
	return $r;
});

return Ans::ans($ans['childs']);