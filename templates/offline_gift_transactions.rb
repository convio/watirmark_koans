require_relative 'lib/example_template.rb'

template = Template::Example.new do
    %Q{
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
    <title>Watirmark Koans</title>

    <style type="text/css">
        table.infoTable
        {
            width:  500px;
        }
        table.transHistoryTable
        {
            width:  700px;
        }

    </style>

    <script type="text/javascript">
        function addGift()
        {
            var name = document.getElementById("donorName").value;
            var amount = document.getElementById("amount").value;
            var payType = document.getElementById("paymentType").value;

            if (name != '' && amount != '' ){
                var date = new Date()
                var curr_date = date.getDate();
                var curr_month = date.getMonth() + 1;
                var curr_year = date.getFullYear();
                var todays_date = curr_month + "-" + curr_date + "-" + curr_year;

                tbody = document.getElementsByTagName("TBODY").item(1);
                row = document.createElement("TR");

                nameCell = document.createElement("TD");
                nameNode = document.createTextNode(name);
                nameCell.appendChild(nameNode);

                dateCell = document.createElement("TD");
                dateNode = document.createTextNode(todays_date);
                dateCell.appendChild(dateNode);

                amountCell = document.createElement("TD");
                amountNode = document.createTextNode(amount);
                amountCell.appendChild(amountNode);

                payTypeCell = document.createElement("TD");
                payTypeNode = document.createTextNode(payType);
                payTypeCell.appendChild(payTypeNode);

                sourceCell = document.createElement("TD");
                sourceNode = document.createTextNode("Offline Gift");
                sourceCell.appendChild(sourceNode);

                row.appendChild(nameCell);
                row.appendChild(dateCell);
                row.appendChild(amountCell);
                row.appendChild(payTypeCell);
                row.appendChild(sourceCell);
                tbody.appendChild(row);

                clear_data();
            }
        }

        function clear_data()
        {
            document.getElementById("donorName").value = "";
            document.getElementById("amount").value = "";
        }


    </script>
</head>
<body>
    <h2>Contact Information</h2>
    <table class="infoTable" id="contactInfoTable" border="1">
        <tr>
            <td>First Name:</td>
            <td>Bobby</td>
        </tr>
        <tr>
            <td>Last Name:</td>
            <td>Joe</td>
        </tr>
        <tr>
            <td>Street Address:</td>
            <td>1235 Oak Hill Lane</td>
        </tr>
        <tr>
            <td>City:</td>
            <td>Austin</td>
        </tr>
        <tr>
            <td>State:</td>
            <td>Texas</td>
        </tr>
        <tr>
            <td>Postal Code:</td>
            <td>78754</td>
        </tr>
    </table>

    <h2>Transaction History</h2>
    <table class="transHistoryTable" id="historyTable" border="1">
        <tr>
            <th>Name</th>
            <th>Transaction Date</th>
            <th>Amount</th>
            <th>Payment Type</th>
            <th>Transaction Source</th>
        </tr>
        <tr>
            <td>John Smith</td>
            <td>1-1-2013</td>
            <td>$25.00</td>
            <td>Credit Card</td>
            <td>Donation Form</td>
        </tr>
        <tr>
            <td>Aaron Rogers</td>
            <td>2-21-2013</td>
            <td>$85.65</td>
            <td>PayPal</td>
            <td>Donation Form</td>
        </tr>
    </table>

    <h2>Add Offline Gift</h2>
    Name: <input type="text" id="donorName">
    Amount: <input type="text" id="amount">
    Payment Type:
    <select id="paymentType">
        <option value="Cash">Cash</option>
        <option value="Credit Card">Credit Card</option>
    </select>
    <br>
    <br>
    <input type="button" value="Add Gift" onclick="addGift()">
</body>
</html>
}
end

puts template.generate

