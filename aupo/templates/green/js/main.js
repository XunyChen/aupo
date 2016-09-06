$('.left-line').click(function(){
	$('.list-mobile').slideToggle()
});
$(document).ready( function() {
$("html").niceScroll({
		cursorborder:'1px solid rgba(255,255,255,0.5)',
		zindex:99
	}); 
});
var bannercont = $('.banner-cont').width();
var widthh = bannercont/2;
$('.banner-cont').css('margin-left',-widthh)
var width = $(window).width();
var height = $(window).height();
$('.banner').css({'width':width+17,'height':height});
$('.banner-img').css({'width':width+17,'height':height});
$(window).scroll(function(){
	var top = $(window).scrollTop();
	if(top >= 10){
		$('.nav').addClass('nav-mini');
		$('.logo-img').attr('src','/upload/product/month_1606/201606101503301572.png');
		$('.logo-img').css({'width':'110px'});
		$('.logo,.list').css('border-right','1px solid #eee');
		$('.list a').css({'height':'60px','line-height':'60px'})
		$('.logokj').css({'height':'60px','width':'141px'})
		$('.scroll-top').css({'opacity':'1'})
	}else if(top <= 50){
		$('.nav').removeClass('nav-mini');
		$('.logo-img').attr('src','/upload/product/month_1606/201606101503301572.png');
		$('.logo-img').css('width','126px');
		$('.logo,.list').css('border-right','1px solid rgba(255,255,255,0.2)');
		$('.list a').css({'height':'100px','line-height':'100px'})
		$('.logokj').css({'height':'102px','width':'157px'})
		$('.scroll-top').css({'opacity':'0'})
	}
	$('.banner').css('height',height - top);
	if(top >= 0 && top < 132){
		$('.banner-cont').css('opacity','1');
	}else if(top>=132 && top < 175){
		$('.banner-cont').css('opacity','0.6');
	}else if(top>=175 && top < 270){
		$('.banner-cont').css('opacity','0.3');
	}else if(top>=270){
		$('.banner-cont').css('opacity','0');
	}

	if(top >= 50){
		$('.about-img-1').css({'margin-left':'3em','opacity':1})
	}
	if(top >= 350){
		$('.opacity-1').css({'margin-top':'0','opacity':1})
		$('.opacity-2').css({'margin-top':'0','opacity':1})
		$('.opacity-3').css({'margin-top':'0','opacity':1})
		$('.back-img').css('opacity','1')
	}
	if(top >= 700){
		$('.index-img-2').css({'opacity':1})
		$('.index-img-3').css({'margin-left':'0','opacity':1})
		$('.index-img-1').css({'margin-right':'0','opacity':1})
	}
});