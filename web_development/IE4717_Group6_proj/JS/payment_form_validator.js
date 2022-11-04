var flag1 = true;
var flag2 = true;
var flag3 = true;
var flag4 = true;
var flag5 = true;
var flag6 = true;
var flag7 = true;
var flag8 = true;

function chk_card_no(event){
    var dom = event.currentTarget;
    var pos = dom.value.search(/\d{16}/);

    if(pos != 0){
        //alert("Card Number must be 16 digit numbers between 0-9.");
        dom.setCustomValidity("Card Number must be 16 digit numbers between 0-9.");
        dom.reportValidity();
        setTimeout(function(){dom.setCustomValidity("");},2000)
        dom.focus();
        dom.select();
        flag1 = false;
        return false;
    }
    flag1 = true;
}

function chk_security_code(event){
    var dom = event.currentTarget;
    var pos = dom.value.search(/\d{3}/);
    if(pos != 0){
        dom.setCustomValidity("Security code must be 3 digit numbers between 0-9");
        dom.reportValidity();
        setTimeout(function(){dom.setCustomValidity("");},2000)
        dom.focus();
        dom.select();
        flag2 = false;
        return false;
    }
    flag2 = true;
}

function chk_expiry_date(){
    var month = document.getElementById('expiry_month');
    var year = document.getElementById('expiry_year');
    var today;

    today = new Date();
    current_month = today.getMonth();
    current_year = today.getFullYear();
    var somedate = new Date();
    somedate.setFullYear(year.value,month.value,1);
    somedate_month = somedate.getMonth();
    somedate_year = somedate.getFullYear();

    if(somedate_year > current_year){
        flag3 = true;
        return true;
    } else if(somedate_year == current_year){
        if(somedate_month >= current_month){
            flag3 = true;
            return true;
        } else {
            month.setCustomValidity("Invalid Expiry Month");
            month.reportValidity();
            setTimeout(function(){month.setCustomValidity("");},2000)
            month.focus();
            month.select();
            flag3 = false;
            return false;
        }
    } else {
        year.setCustomValidity("Invalid Expiry Year");
        year.reportValidity();
        setTimeout(function(){year.setCustomValidity("");},2000)
        year.focus();
        year.select();
        flag3 = false;
        return false;
    }
}

function chk_name_onCard(event){
    var dom = event.currentTarget;
    //var pattern = /([a-z]+ ?){2,4}/;
    var pattern = /^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/g;
    var pos = dom.value.search(pattern);

    if(pos == -1){
        dom.setCustomValidity("Name must not include invalid characters.(e.g. digits, $,@,%,&) and have more than one word.");
        dom.reportValidity();
        setTimeout(function(){dom.setCustomValidity("");},2000)
        dom.focus();
        dom.select();
        flag4 = false;
        return false;
    } else {
        dom.value = dom.value.toUpperCase();
        flag4 = true;
        return true;
    }
}

function chk_deli_name(event){
    var dom = event.currentTarget;
    //var pattern = /([a-z]+ ?){1,3}/;
    var pattern = /^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/g;
    var pos = dom.value.search(pattern);

    if(pos!= 0){
        dom.setCustomValidity("Name must not include invalid characters.(e.g. digits, $,@,%,&) and have one or more than one word." + 
                              "\nFirst letter must be uppercase for every word. e.g. John Smith");
        dom.reportValidity();
        setTimeout(function(){dom.setCustomValidity("");},2000)
        dom.focus();
        dom.select();
        flag5 = false;
        return false;
    } else {
        dom.value = dom.value.toUpperCase();
        flag5 = true;
        return true;
    }
}

function chk_postal_code(event){
    var dom = event.currentTarget;
    var pattern = /\d{6}/;
    var pos = dom.value.search(pattern);

    if(pos!=0){
        dom.setCustomValidity("Invalid Postal Code. Singapore Postal code is 6-digit number.");
        dom.reportValidity();
        setTimeout(function(){dom.setCustomValidity("");},2000)
        dom.focus();
        dom.select();
        flag6 = false;
        return false;
    }
    flag6 = true;
}

function chk_address(event){
    var dom = event.currentTarget;
    var pattern = /[@!#$%^&*]/g;
    var pos = dom.value.search(pattern);

    if(pos != -1){
        dom.setCustomValidity("Address must not include invalid characters. (!@#$%%^&*).");
        dom.reportValidity();
        setTimeout(function(){dom.setCustomValidity("");},2000)
        dom.focus();
        dom.select();
        flag7 = false;
        return false;
    }
    flag7 = true;
}

function chk_contact_no(event){
    var dom = event.currentTarget;
    var pattern = /\d{8}/;
    var pos = dom.value.search(pattern);

    if(pos != 0){
        dom.setCustomValidity("Invalid Contact Number");
        dom.reportValidity();
        setTimeout(function(){dom.setCustomValidity("");},2000)
        dom.focus();
        dom.select();
        flag8 = false;
        return false;
    }
    flag8 = true;
}