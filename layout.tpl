{root:}
	<style>
		#{div} {
			font-size:110%;
		}
		#{div} .submenu {
			background-color:{config.subbg};
			
			text-transform: none;
			position:absolute;
			display:none;
			/*padding-bottom:0.5rem;
			border-radius: 0 0 20px 10px;
			border-radius: 0 0 2px 2px;*/
		}
		
		/*#{div} .nav {
			margin-left: -10px;
			margin-right: -10px;

		}*/
		#{div} .nav > li {
			text-transform: uppercase;
		}
		
	</style>
	<ul class="nav justify-content-center">
		{data.childs::mitem}
	</ul>
	<script>
		domready(function(){
			var div = $('#{div}');
			div.find('li.subgroups > a').hover( function () {
				var li = $(this).parent();
				div.find('li').not(li).find('.submenu').stop().slideUp().css('z-index',1);
				$(li).find('.submenu').stop().slideDown().css('z-index',2);
			});
			Once.exec('groupsdownbreak', function() {
				$('body').click( function (e) {
					if ($(e.target).parents().filter('#{div}').length) {
						if ($(e.target).is('a')) var a = $(e.target);
						else var a = $(e.target).parents('a:first');
						if (!a.parent().find('>.submenu').length) {
							div.find('.submenu').stop().slideUp('fast');
						}
					} else {
						div.find('.submenu').stop().slideUp('fast');
					}
				});
			});
		})
	</script>
	{mitem:}
		<li class="nav-item {childs?:strsubgroups}">
			<a class="nav-link" href="{Ссылка}">{Название}{childs?:mark}</a>
			{childs:subgroup}
		</li>
	{mark:}&nbsp;<i class="fas fa-chevron-circle-down"></i>
	{strsubgroups:}subgroups
	{subgroup:}
		<div class="submenu">
			{::subitem}
		</div>
		{subitem:}<a href="{Ссылка}">{Название}</a><span> </span>
{mobile:}
	<ul class="nav">
		{data.childs::mitemm}
	</ul>
	{mitemm:}
		<li class="nav-item level1 {childs?:strsubgroups}">
			<a class="nav-link" href="{Ссылка}">{Название}{childs?:mark}</a>
			{childs:subgroup}
		</li>