function parse(results) {
    var searchResults = {
        movie: [],
        podcast: [],
        music: [],
        musicVideo: [],
        audiobook: [],
        shortFilm: [], // I Don't think this is different from feature-movie
        tvShow: [],
        software: [],
        ebook: []
     };

    for (index in results) {
        const resultItem = results[index]; 
        const wrapperType = resultItem.wrapperType
        const kind = resultItem.kind

        switch (wrapperType) {
            case `audiobook`:
                let audiobookItem = parseAudiobookSearchResult(resultItem);
                searchResults.audiobook.push(audiobookItem);
                break;
            case `software`:
                let softwareItem = parseSoftwareSearchResult(resultItem);
                searchResults.software.push(softwareItem);
                break;
            case `track`:
                switch (kind) {
                    case `feature-movie`:
                        let movieItem = parseMovieSearchResult(resultItem);
                        searchResults.movie.push(movieItem);
                        break;
                    case `music-video`:
                        let musicVideoItem = parseMusicVideoSearchResult(resultItem);
                        searchResults.musicVideo.push(musicVideoItem);
                        break;
                    case `podcast`:
                        let podcastItem = parsePodcastSearchResult(resultItem);
                        searchResults.podcast.push(podcastItem);
                        break;
                    case `song`:
                        let songItem = parseSongSearchResult(resultItem);
                        searchResults.music.push(songItem);
                        break;
                    case `tv-episode`:
                        let tvEpisodeItem = parseTVEpisodeSearchResult(resultItem);
                        searchResults.tvShow.push(tvEpisodeItem);
                        break;
                    default:
                        break;
                }
                break;
            default:
                switch (kind) {
                    case `ebook`:
                        let ebookItem = parseEbookSearchResult(resultItem);
                        searchResults.ebook.push(ebookItem);
                        break;
                    default:
                        break;
                }
                break
        }
    }

    return searchResults;
}

function parseArtworkUrl(resultItem) {
    if (resultItem.artworkUrl600 != null) {
        return resultItem.artworkUrl600;
    } else if (resultItem.artworkUrl512 != null) {
        return resultItem.artworkUrl512;
    } else if (resultItem.artworkUrl100 != null) {
        return resultItem.artworkUrl100;
    } else if (resultItem.artworkUrl60 != null) {
        return resultItem.artworkUrl60;
    } else if (resultItem.artworkUrl30 != null) {
        return resultItem.artworkUrl30;
    } else {
        return null
    }
}

function parsePodcastSearchResult(resultItem) {
    return {
        id: resultItem.collectionId,
        name: resultItem.collectionName,
        artwork: parseArtworkUrl(resultItem),
        genre: resultItem.primaryGenreName,
        url: resultItem.collectionViewUrl
    }
}

function parseSoftwareSearchResult(resultItem) {
    return {
        id: resultItem.trackId,
        name: resultItem.trackName,
        artwork: parseArtworkUrl(resultItem),
        genre: resultItem.primaryGenreName,
        url: resultItem.trackViewUrl
    }
}

function parseAudiobookSearchResult(resultItem) {
    return {
        id: resultItem.collectionId,
        name: resultItem.collectionName,
        artwork: parseArtworkUrl(resultItem),
        genre: resultItem.primaryGenreName,
        url: resultItem.collectionViewUrl
    }
}

function parseSongSearchResult(resultItem) {
    return {
        id: resultItem.trackId,
        name: resultItem.trackName,
        artwork: parseArtworkUrl(resultItem),
        genre: resultItem.primaryGenreName,
        url: resultItem.trackViewUrl
    }
}

function parseMovieSearchResult(resultItem) {
    return {
        id: resultItem.trackId,
        name: resultItem.trackName,
        artwork: parseArtworkUrl(resultItem),
        genre: resultItem.primaryGenreName,
        url: resultItem.trackViewUrl
    }
}

function parseMusicVideoSearchResult(resultItem) {
    return {
        id: resultItem.trackId,
        name: resultItem.trackName,
        artwork: parseArtworkUrl(resultItem),
        genre: resultItem.primaryGenreName,
        url: resultItem.trackViewUrl
    }
}

function parseTVEpisodeSearchResult(resultItem) {
    return {
        id: resultItem.trackId,
        name: resultItem.trackName,
        artwork: parseArtworkUrl(resultItem),
        genre: resultItem.primaryGenreName,
        url: resultItem.trackViewUrl
    }
}

function parseEbookSearchResult(resultItem) {
    return {
        id: resultItem.trackId,
        name: resultItem.trackName,
        artwork: parseArtworkUrl(resultItem),
        genre: resultItem.primaryGenreName,
        url: resultItem.trackViewUrl
    }
}

exports.parse = parse;