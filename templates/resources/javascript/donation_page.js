function selectPaymentType(){
    var paymentType = document.getElementById("payment_type").value;
    var credit = document.getElementById("credit_payment_type");
    var check = document.getElementById("check_payment_type");

    if (paymentType == "Check"){
        credit.className = "hidden";
        check.className = "notHidden";
    }
    else if (paymentType == "Credit") {
        check.className = "hidden";
        credit.className = "notHidden";
    }
    else {
        check.className = "hidden";
        credit.className = "hidden";
    }
}

function resetForm(){
    var credit = document.getElementById("credit_payment_type");
    var check = document.getElementById("check_payment_type");
    check.className = "hidden";
    credit.className = "hidden";
}