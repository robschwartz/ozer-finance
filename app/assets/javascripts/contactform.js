
jQuery(document).ready(function ($) {
    "use strict";

    //Contact
    $('form.contactForm').submit(function () {

        var f = $(this).find('.form-group'),
            ferror = false,
            emailExp = /^[^\s()<>@,;:\/]+@\w[\w\.-]+\.[a-z]{2,}$/i,
            phoneExp = /^\d{3}[\-]?\d{3}[\-]?\d{4}$/;

        f.children('input').each(function () { // run all inputs

            var i = $(this); // current input
            var rule = i.attr('data-rule');
            console.log(rule);

            if (rule !== undefined) {
                var ierror = false; // error flag for current input
                var pos = rule.indexOf(':', 0);
                if (pos >= 0) {
                    var exp = rule.substr(pos + 1, rule.length);
                    rule = rule.substr(0, pos);
                } else {
                    rule = rule.substr(pos + 1, rule.length);
                }

                switch (rule) {
                    case 'required':
                        if (i.val() === '') { ferror = ierror = true; }
                        break;

                    case 'minlen':
                        if (i.val().length < parseInt(exp)) { ferror = ierror = true; }
                        break;

                    case 'phone':
                        if (!phoneExp.test(i.val())) { ferror = ierror = true; }
                        break;

                    case 'email':
                        if (!emailExp.test(i.val())) { ferror = ierror = true; }
                        break;

                    case 'checked':
                        if (!i.attr('checked')) { ferror = ierror = true; }
                        break;

                    case 'regexp':
                        exp = new RegExp(exp);
                        if (!exp.test(i.val())) { ferror = ierror = true; }
                        break;
                }
                i.next('.validation').html((ierror ? (i.attr('data-msg') !== undefined ? i.attr('data-msg') : 'wrong Input') : '')).show('blind');
            }
        });
        f.children('textarea').each(function () { // run all inputs

            var i = $(this); // current input
            var rule = i.attr('data-rule');

            if (rule !== undefined) {
                var ierror = false; // error flag for current input
                var pos = rule.indexOf(':', 0);
                if (pos >= 0) {
                    var exp = rule.substr(pos + 1, rule.length);
                    rule = rule.substr(0, pos);
                } else {
                    rule = rule.substr(pos + 1, rule.length);
                }

                switch (rule) {
                    case 'required':
                        if (i.val() === '') { ferror = ierror = true; }
                        break;

                    case 'minlen':
                        if (i.val().length < parseInt(exp)) { ferror = ierror = true; }
                        break;
                }
                i.next('.validation').html((ierror ? (i.attr('data-msg') != undefined ? i.attr('data-msg') : 'wrong Input') : '')).show('blind');
            }
        });
        if (ferror) return false;
        else var str = $(this).serialize();
        var postUrl = "/send-contact-form"
        if (str.includes('help_form')) {
            postUrl = "/provider/request-info";
        }
        $.ajax({
            type: "POST",
            url: postUrl,
            data: str,
            success: function (msg) {
                if (str.includes('help_form')) {
                    window.location.replace("/thank-you")
                }
                // alert(msg);
                $("#sendmessage").addClass("show");
                $("#errormessage").removeClass("show");
            }
        });
        return false;
    });

});

$(document).ready(function () {
    $('.registration-form fieldset:first-child').fadeIn('slow');

    $('.registration-form input[type="text"]').on('focus', function () {
        $(this).removeClass('input-error');
    });

    // next step
    $('.registration-form .btn-next').on('click', function () {
        var parent_fieldset = $(this).parents('fieldset'),
            next_step = true,
            emailExp = /^[^\s()<>@,;:\/]+@\w[\w\.-]+\.[a-z]{2,}$/i,
            phoneExp = /^\d{3}[\-]?\d{3}[\-]?\d{4}$/;

        parent_fieldset.find('input[type="text"],input[type="email"],input[type="number"],input[type="date"],select[name="annual_sales"]').each(function () {
            if ($(this).val() == "") {
                console.log('input', $(this).val())
                $(this).addClass('input-error');
                next_step = false;
            }
            else {
                $(this).removeClass('input-error');
            }
        });

        parent_fieldset.find('input[name="email"]').each(function () {
            if (!emailExp.test($(this).val())) {
                console.log('email', $(this).val())
                $(this).addClass('input-error');
                document.getElementById("email").value = "Please enter a valid email";
                next_step = false;
            }
            else {
                $(this).removeClass('input-error');
            }
        });

        parent_fieldset.find('input[name="number"]').each(function () {
            if (!phoneExp.test($(this).val())) {
                console.log('phone', $(this).val())
                $(this).addClass('input-error');
                document.getElementById("phone").value = "Please enter a valid number";
                next_step = false;
            }
            else {
                $(this).removeClass('input-error');
            }
        });

        if (next_step) {
            parent_fieldset.fadeOut(400, function () {
                $(this).next().fadeIn();
            });
        }

    });

    // previous step
    $('.registration-form .btn-previous').on('click', function () {
        $(this).parents('fieldset').fadeOut(400, function () {
            $(this).prev().fadeIn();
        });
    });

    // submit
    $('.registration-form').on('submit', function (e) {

        $(this).find('input[type="text"],input[type="email"]').each(function () {
            if ($(this).val() == "") {
                e.preventDefault();
                $(this).addClass('input-error');
            } else {
                $(this).removeClass('input-error');
            }
        });

        var str = $(this).serialize();
        var postUrl = "/send-contact-form"
        if (str.includes('help_form')) {
            postUrl = "/provider/request-info";
        }

        $.ajax({
            type: "POST",
            url: postUrl,
            data: str,
            success: function (msg) {
                if (str.includes('help_form')) {
                    window.location.replace("/thank-you")
                }
            }
        });
    });


});
