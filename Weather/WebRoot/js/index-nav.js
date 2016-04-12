$(function(){
	$(".hz-index-nav .clearfix li").hover(function(){
		if(!$(this).hasClass("act")){
			//switch index-nav
			$(this).addClass('act');
			$(this).siblings('li').removeClass('act');
			var id = $(this).attr('data-id');

			//show details
			$('.tabs').children('div').each(function(){
				if($(this).attr('id') == id){
					if(!$(this).hasClass('act')){
						$(this).addClass('act');
						var index = $('.tabs').children('div').index($(this));
						var left = $('.hz-index-nav .clearfix').width()/8*index;
						$('.bottom-act.hidden-xs.hidden-sm').css("margin-left",left+"px");
					}
				}else{
					if($(this).hasClass('act')){
						$(this).removeClass('act');
					}
				}
			});
		}
	});
});