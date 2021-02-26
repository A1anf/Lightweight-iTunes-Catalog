const express = require('express');
const request = require('request');
const searchResultParser = require('./search_result_parser');
const app = express();
const port = 3333;

app.get('/search', (endpointRequest, endpointResponse) => {
    let searchTerm = endpointRequest.query.term;
    
    request(`https://itunes.apple.com/search?term=${searchTerm}`, { json: true }, (searchError, searchResponse, searchBody) => {
        if (searchError) {
            endpointResponse.status(500);
            endpointResponse.json({errorMessage: 'Failed to search'});
            return console.log(searchError);
        }

        const results = searchBody.results;
        const endpointResponseData = searchResultParser.parse(results);

        endpointResponse.json(endpointResponseData);
    });
});

app.listen(port, () => {
    console.log(`Server listening on port: ${port}`);
});