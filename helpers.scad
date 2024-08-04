
function includes(main_str, sub_str) = len(search(sub_str, main_str)) > 0;

module report(msg) {
    if (includes(flags, "o")) {
        echo(msg);
    }
}

module debug(msg) {
    if (! includes(flags, "n")) {
        echo(msg);
    }
}


// Simulate an associative array using nested lists
ExampleHash = [
    ["bottlecapacity", "100"],
    ["orientation", "vertical"],
    ["width",  100],
    ["height", 200],
    ["depth",  50]
];

// Helper function to find the key-value pair
function searchArray(array, key) = 
    [for (i = [0 : len(array) - 1]) if (array[i][0] == key) array[i][1]];

// Function to get value by key (for single-level hash)
function getValueByKey(array, key) =
    let(pair = searchArray(array, key))
    pair[1];

// Usage for simple hash 
orientation = getValueByKey(ExampleHash, ["orientation"]);
bottle_capacity = getValueByKey(ExampleHash, ["dimensions"]);

// Usage for nested object
width = getValueByKey(ExampleHash, ["dimensions", "width"]);
height = getValueByKey(ExampleHash, ["dimensions", "height"]);
depth = getValueByKey(ExampleHash, ["dimensions", "depth"]);

// echo(orientation, width, height, depth, bottle_capacity); 


// Helper function to convert value to JSON string
function ToJSON(value) =
    is_list(value) ? (
        str("[", concat([for (i = [0 : len(value) - 1]) ToJSON(value[i])], ", "), "]")
    ) : (
        is_string(value) ? str("\"", value, "\"") : str(value)
    );

// Function to convert key-value pair to JSON string
function KeyValueToJSON(pair) = str("\"", pair[0], "\": ", ToJSON(pair[1]));

// Function to convert associative array to JSON string
function ConvertToJSON(array) =
    str("{", concat([for (i = [0 : len(array) - 1]) KeyValueToJSON(array[i])], ", "), "}");

// Convert the object to JSON and echo it
// jsonRepresentation = ConvertToJSON(ExampleHash);
// echo(jsonRepresentation);






