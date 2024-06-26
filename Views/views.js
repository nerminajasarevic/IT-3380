/* Nermina Jasarevic */
/* IT 3380 */
/* Views in Mongo DB */

/* 1. Write a query to create a view named "custByCity" to get a count of how many customers there are in each city. */
db.createView(
    "custByCity",
    "customers",
    [ 
        { $group: { _id: "$city", count: {$sum: 1} } } 
    ]
)

/* 1. Query the custByCity view to show the number of customers in Singapore. */
db.custByCity.find({ "_id": "Singapore" })

/* 2. Write a query to create a view named "paymentsByMonth" that calculates payments per month. You will have to group by multiple columns for this query: month and year because payments from January 2004 and January 2005 should not be grouped together. Remember the SQL month() and year() functions. */
db.createView(
    "paymentsByMonth",
    "customers",
    [
        { $unwind: "$payments" },
        { $group: { _id: { year: { $year: "$payments.paymentDate" }, month: { $month: "$payments.paymentDate" }, TotalPayments: { $sum: 1 } } } }
    ]
)

/* 2. Query the paymentsByMonth view to show payments in November 2004 */
db.paymentsByMonth.find({ "_id.month": 11, "_id.year": 2004 })

/* 3. Write a query to create a view named "orderTotalsByMonth" to calculate order totals (in dollars) per month. */
db.createView(
    "orderTotalsByMonth",
    "orders",
    [
        { $unwind: "$orderDetails" },
        { $group: { _id: { year: { $year: "$orderDate" }, month: { $month: "$orderDate" } }, TotalOrder: { $sum: "$orderDetails.priceEach" } } }
    ]
)

/* 3. Query the orderTotalsByMonth view to show the order total in August 2004. */
db.orderTotalsByMonth.find({ "_id.month": 8, "_id.year": 2004 })

/* 4. Write a query to create a view named "productSalesYear" that calculates sales per product per year. Include the product name, sales total, and year. */
db.createView(
    "productSalesYear",
    "orders",
    [
        { $unwind: "$orderDetails" },
        { $group: { _id: { product: "$orderDetails.productName", year: { $year: "$orderDate" } }, TotalSales: { $sum: "$orderDetails.priceEach" } } },
        { $sort: { _id: 1 } }
    ]
)

/* 4. Query the productSalesYear view to show the sales per year for the "2001 Ferrari Enzo" */
db.productSalesYear.find({ "_id.product": "2001 Ferrari Enzo" })

/* 5. Write a query to create a view named "orderTotals" that displays the order total for each order. Include order number, customer name, and total. */
db.createView(
    "orderTotals",
    "orders",
    [
        { $unwind: "$orderDetails" },
        { $addFields: { "orderTotal": { $multiply: ["$orderDetails.quantity", "$orderDetails.priceEach"] } } },
        { $group: { _id: { "customerName": "$customerName", "orderNumber": "$orderNumber" }, TotalOrder: { $sum: "$orderTotal" } } }
    ]
)

/* 5. Query the orderTotals view to select the top 15 orders. */
db.orderTotals.find().sort({ TotalOrder: -1 }).limit(15)
