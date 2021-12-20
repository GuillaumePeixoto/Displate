
$(document).ready(function(){

    $('.quantity-right-plus').click(function(e){
        e.preventDefault();
        var quantity = parseInt($('#quantity').val());
        $('#quantity').val(quantity + 1);
    });

    $('.quantity-left-minus').click(function(e){
        e.preventDefault();
        var quantity = parseInt($('#quantity').val());
        if(quantity > 1){
            $('#quantity').val(quantity - 1);
        }
    });


    $('#carousel1').carousel('pause');
    $('#carousel2').carousel('pause');
    $('#carousel3').carousel('pause');

    $('#add_photo #produit_form_photo').change(function(event){
        var src = URL.createObjectURL(event.target.files[0]);
        var preview = document.getElementById("file-preview");
        var preview_block = document.getElementById("block-preview");
        preview.src = src;
        preview.style.display = "block";
        preview_block.style.display = "block";
    });

    $('#add_photo_profil').change(function(event){
        var src = URL.createObjectURL(event.target.files[0]);
        var preview = document.getElementById("profil-preview");
        var preview_block = document.getElementById("block-profil-preview");
        preview.src = src;
        preview.style.display = "initial";
        preview_block.style.display = "block";
    });

    $('#add_photo #produit_form_photo').change(function(event){
        var src = URL.createObjectURL(event.target.files[0]);
        var preview = document.getElementById("file-preview");
        var preview_block = document.getElementById("block-preview");
        preview.src = src;
        preview.style.display = "block";
        preview_block.style.display = "block";
    });


});



  

