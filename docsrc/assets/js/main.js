

function HighlightLines(text, startLine, endLine) {
    // Split the text by newlines into an array
    let lines = text.split('\n');
    
    // Check if the first element is an empty string and remove it
    if (lines[0] === '') {
        lines.shift();
    }

    // Loop through the lines and wrap the specified lines in <b> tags
    for (let i = startLine; i <= endLine; i++) {
        if (i >= 0 && i < lines.length) {
            lines[i] = `<b>${lines[i]}</b>`;
        }
    }

    // Join the lines back into a single string with newlines
    const highlightedText = lines.join('\n');
    
    const code = document.createElement('code');
    code.innerHTML = highlightedText;
    const pre = document.createElement('pre');
    pre.appendChild(code);

    return pre;
}

function ExplodeDesignInfo(info) {

    // info is in the following format:
    // H128-36.5x36.5x35-512-un
    
    let props = info.split('-');

    const finalProps = {};
    finalProps.model_number = props[0];

    const orient = finalProps.model_number; 
    finalProps.orientation = (orient.toLowerCase() == "v") ? "vertical" : "horizontal";
    finalProps.capacity = finalProps.model_number.slice(1) + " bottles";
   
    finalProps._dims = props[1];
    const dimparts = finalProps._dims.split('x');
    finalProps.height = dimparts[0] + " inches";
    finalProps.width = dimparts[1] + " inches";
    finalProps.depth = dimparts[2] + " inches";

    finalProps.estimated_load = props[2] + " pounds";
    finalProps._flags = props[3];

    return finalProps;
}

// any keys/properties starting with an underscore will not be displayed
function PropTable(info) {
    // Create the table element
    const table = document.createElement('table');
    table.border = '1';
    const tbody = document.createElement('tbody');
    
    // Create the table rows for each key-value pair
    for (const [key, value] of Object.entries(info)) {
        if (! key.startsWith('_')) {
            const row = document.createElement('tr');
            const keyCell = document.createElement('th');
            const keytext = key.replace("_", " "); 
            keyCell.textContent = keytext;
            row.appendChild(keyCell);
            const valueCell = document.createElement('td');
            valueCell.textContent = value;
            row.appendChild(valueCell);
            tbody.appendChild(row);
        }
    }

    // Append the tbody to the table
    table.appendChild(tbody);
    return table;
}

function InsertContent(selector, content) {
    console.log("SELECTOR: " + selector);
    const wrapper = document.querySelector(selector);
    if (wrapper) {
        wrapper.appendChild(content);
    } else {
        console.error('The selector: ' + selector + ' not found in the document.');
    }
}

function InsertHighlightedLines(selector, text, startLine, endLine) {
    const code = HighlightLines(text, startLine, endLine); 
    InsertContent(selector, code);
}

function InsertFigure(selector, width, modelinfo) {
    const img = document.createElement('img');
    img.src = "assets/img/previews/" + modelinfo + ".png"; 
    img.width = width;
    console.log("IMAGE:" + img.src);

    const data = ExplodeDesignInfo(modelinfo);
    const table = PropTable(data);
    //const footer = document.createElement('footer');
    //footer.appendChild(table);

    const fig = document.createElement('figure');
    fig.appendChild(img);
    fig.appendChild(table);
    //fig.appendChild(footer);
    InsertContent(selector, fig);
}









/*
let propHash= {
    name: 'wine cube',
    orientation: "vertical"
};

PropTable(propHas);

function CSVToTable(info, isFirstRowHeader = true) {
    // Create a table element
    const table = document.createElement('table');
    const tbody = document.createElement('tbody');

    // If the first row should be the header
    if (isFirstRowHeader) {
        const thead = document.createElement('thead');
        const headerRow = document.createElement('tr');
        info[0].forEach(headerText => {
            const th = document.createElement('th');
            th.textContent = headerText;
            headerRow.appendChild(th);
        });
        thead.appendChild(headerRow);
        table.appendChild(thead);

        // Remove the header row from the info
        info.shift();
    }

    // Populate the table rows
    info.forEach((row, rowIndex) => {
        const tr = document.createElement('tr');
        row.forEach((cell, colIndex) => {
            const td = document.createElement('td');
            if (!isFirstRowHeader && rowIndex === 0) {
                // Treat the first column as a header if specified
                const th = document.createElement('th');
                th.textContent = cell;
                tr.appendChild(th);
            } else {
                td.textContent = cell;
                tr.appendChild(td);
            }
        });
        tbody.appendChild(tr);
    });

    table.appendChild(tbody);
    return table;
}

// 2D array structured like CSV, table info
let propCSV = [
    ['Header 1', 'Header 2', 'Header 3'],
    ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3'],
    ['Row 2, Cell 1', 'Row 2, Cell 2', 'Row 2, Cell 3'],
    ['Row 3, Cell 1', 'Row 3, Cell 2', 'Row 3, Cell 3']
];


// Call the function with info and a flag indicating whether the first row should be treated as a header
CSVToTable(propCSV, true); // Treat the first row as header
 CSVToTable(info, false); // Treat the first column as header

*/
