{root:}
	<style>
		#{div} .submenu {
			background-color:{config.subbg};
			padding:0px 1rem;
			padding-bottom:0.5rem;
			text-transform: none;
			position:absolute;
			display:none;

			border-radius: 0 0 20px 10px;
		}
		#{div} .submenu a {
			margin-bottom:3px;
			display:block;	
		}
		#{div} .nav {
			margin-left: -16px;
			margin-right: -16px;

		}
		#{div} .nav > li {
			text-transform: uppercase;
		}
		@media (max-width: 991px) {
			#{div} .submenu {
				font-size:14px;
				position:static;
			}
		}

	</style>
	<ul class="nav">
		{data.childs::mitem}
	</ul>
	<script>
		domready(function(){
			var div = $('#{div}');
			div.find('li.subgroups > a').hover( function () {
				var li = $(this).parent();
				div.find('li').not(li).find('.submenu').stop().css('height','auto').slideUp().css('z-index',1);
				$(li).find('.submenu').stop().css('height','auto').slideDown().css('z-index',2);
			});
			Once.exec('groupsdownbreak', function() {
				$('body').click( function (e) {
					if ($(e.target).parents().filter('#{div}').length) {
						if ($(e.target).is('a')) var a = $(e.target);
						else var a = $(e.target).parents('a:first');
						if (!a.parent().find('>.submenu').length) {
							div.find('.submenu').stop().css('height','auto').slideUp('fast');
						}
					} else {
						div.find('.submenu').stop().css('height','auto').slideUp('fast');
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
		{subitem:}<a href="{Ссылка}">{Название}</a>