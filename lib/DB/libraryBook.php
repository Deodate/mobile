<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "mobileflutter";
$table = "book";

$action = $_POST["action"];

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection Failed: " . $conn->connect_error);
}

if ("CREATE_TABLE" == $action) {
    $sql = "CREATE TABLE IF NOT EXISTS $table (
        id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        bookName VARCHAR(30) NOT NULL,
        authorName VARCHAR(30) NOT NULL,
        pageNumber INT(20) NOT NULL,
        datePublished DATE,
        cityPublish VARCHAR(30) NOT NULL
    )";

    if ($conn->query($sql) === TRUE) {
        echo "success";
    } else {
        echo "error: " . $conn->error;
    }
    $conn->close();
    return;
}

if ("GET_ALL" == $action) {
    $db_data = array();
    $sql = "SELECT id, bookName, authorName, pageNumber, datePublished, cityPublish FROM $table ORDER BY id DESC";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    } else {
        echo "error: No records found";
    }
    $conn->close();
    return;
}

// Add Book
if ("ADD_BOOK" == $action) {
    $bookName = $_POST["bookName"];
    $authorName = $_POST["authorName"];
    $pageNumber = $_POST["pageNumber"];
    $datePublished = $_POST["datePublished"];
    $cityPublish = $_POST["cityPublish"];

    $sql = "INSERT INTO $table (bookName, authorName, pageNumber, datePublished, cityPublish) VALUES ('$bookName', '$authorName', $pageNumber, '$datePublished', '$cityPublish')";

    if ($conn->query($sql) === TRUE) {
        echo "Success";
    } else {
        echo "Error: " . $conn->error;
    }
    $conn->close();
    return;
}

// Update Book
if ("UPDATE_BOOK" == $action) {
    $id = $_POST["id"];
    $bookName = $_POST["bookName"];
    $authorName = $_POST["authorName"];
    $pageNumber = $_POST["pageNumber"];
    $datePublished = $_POST["datePublished"];
    $cityPublish = $_POST["cityPublish"];

    $sql = "UPDATE $table SET bookName='$bookName', authorName='$authorName', pageNumber=$pageNumber, datePublished='$datePublished', cityPublish='$cityPublish' WHERE id=$id";

    if ($conn->query($sql) === TRUE) {
        echo "Success";
    } else {
        echo "Error: " . $conn->error;
    }
    $conn->close();
    return;
}

if ("DELETE_BOOK" == $action) {
    $id = $_POST["id"];

    $sql = "DELETE FROM $table WHERE id=$id";

    if ($conn->query($sql) === TRUE) {
        echo "Success";
    } else {
        echo "Error: " . $conn->error;
    }
    $conn->close();
    return;
}
?>
