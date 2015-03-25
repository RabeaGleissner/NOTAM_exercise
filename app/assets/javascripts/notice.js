$(function(){

  $('form').submit(function(ev){
    ev.preventDefault();
    
  var input = $('#input').val();
  console.log(input);

  if (input.indexOf("AERODROME HOURS OF OPS/SERVICE") != -1) {
     this.submit();
  } else { 
      $(".error").slideToggle();
  }

  });



});