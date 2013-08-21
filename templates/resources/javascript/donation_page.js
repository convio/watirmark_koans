function selectPaymentType(){

    var creditRadio = document.getElementById("credit_payment_method");
    var checkRadio = document.getElementById("check_payment_method");


    var credit = document.getElementById("credit_payment_type");
    var check = document.getElementById("check_payment_type");

    if (creditRadio.checked) {
        check.className = "hidden";
        credit.className = "notHidden";
    } else {
        credit.className = "hidden";
        check.className = "notHidden";
    }
}

function resetForm(){
    var credit = document.getElementById("credit_payment_type");
    var check = document.getElementById("check_payment_type");
    check.className = "hidden";
    credit.className = "hidden";
}