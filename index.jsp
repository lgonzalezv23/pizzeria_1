<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/images.css">
</head>
<body>

<div class="topnav">
    <a class="active" href="index.jsp">PIZZERA</a>
    <a href="menu.html">Menu</a>
    <a href="#contact">Contact</a>
    <a href="main.jsp" class="split">Perfil</a>
</div>

<div style="padding-left:16px">
    <h2>PIZZERA El arte de comer Pizza</h2>
</div>

<!-- Slideshow container -->
<div class="slideshow-container">
    <div class="mySlides fade">
        
        <img src="images/peperoni1.jpg" style="width:100%">
        <div class="text">Peperoni</div>
    </div>

    <div class="mySlides fade">
        
        <img src="images/hawaiana.jpg" style="width:100%">
        <div class="text">Hawaiana</div>
    </div>

    <div class="mySlides fade">
        
        <img src="images/mexicana.jpg" style="width:100%">
        <div class="text">Mexicana</div>
    </div>
</div>
<br>

<div style="text-align:center">
    <span class="dot"></span>
    <span class="dot"></span>
    <span class="dot"></span>
</div>

<script>
    let slideIndex = 0;
    showSlides();

    function showSlides() {
        let i;
        let slides = document.getElementsByClassName("mySlides");
        let dots = document.getElementsByClassName("dot");
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slideIndex++;
        if (slideIndex > slides.length) {
            slideIndex = 1
        }
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        slides[slideIndex - 1].style.display = "block";
        dots[slideIndex - 1].className += " active";
        setTimeout(showSlides, 4000); // Change image every 2 seconds
    }
</script>

</body>
</html>
