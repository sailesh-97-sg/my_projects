//Delivery Address Validation-----------------------------------
var delivery_address = document.getElementsByClassName('delivery');
delivery_address[0].addEventListener("change", chk_deli_name ,false);
delivery_address[1].addEventListener("change", chk_deli_name ,false);

delivery_address[2].addEventListener("change", chk_postal_code , false);
delivery_address[4].addEventListener("change", chk_address , false); 
delivery_address[5].addEventListener("change", chk_contact_no , false);
//-------------------------------------------------------------
//Billing Address Validation-----------------------------------
var billing_address = document.getElementsByClassName('billing');
billing_address[0].addEventListener("change", chk_postal_code ,false);
billing_address[1].addEventListener("change", chk_address ,false);