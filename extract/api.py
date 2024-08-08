from datetime import datetime, timedelta

def get_channel_playlists(service, channel_id):
    playlists = []
    next_page_token = None

    while True:
        request = service.playlists().list(
            part="id,snippet",
            channelId=channel_id,
            maxResults=50,
            pageToken=next_page_token
        )
        response = request.execute()

        for item in response['items']:
            playlists.append({'playlist_id': item['id'], 'title': item['snippet']['title']})

        next_page_token = response.get('nextPageToken')
        if not next_page_token:
            break

    return playlists

def get_videos_in_playlist(service, playlist_id):
    videos = []
    next_page_token = None

    request = service.playlistItems().list(
        part="contentDetails,snippet",
        playlistId=playlist_id,
        maxResults=50,
        pageToken=next_page_token
    )
    response = request.execute()

    for item in response['items']:
        video_id = item['contentDetails']['videoId']
        title = item['snippet']['title']
        videos.append({'video_id': video_id, 'title': title})

    return videos

def get_uploads_playlist_id(youtube, channel_id):
    request = youtube.channels().list(
        part="contentDetails",
        id=channel_id
    )
    response = request.execute()
    return response['items'][0]['contentDetails']['relatedPlaylists']['uploads']



def get_playlist_videos(youtube, playlist_id):
    videos = []
    next_page_token = None

    while True:
        request = youtube.playlistItems().list(
            part="snippet",
            playlistId=playlist_id,
            maxResults=50,
            pageToken=next_page_token
        )
        response = request.execute()

        for item in response['items']:
            video_id = item['snippet']['resourceId']['videoId']
            # title = item['snippet']['title']
            videos.append(video_id)

        next_page_token = response.get('nextPageToken')
        if not next_page_token:
            break

    return videos



def get_video_details(service, video_id):
    today = datetime.now()
    request = service.videos().list(
        part="snippet,contentDetails,statistics",
        id=video_id
    )
    response = request.execute()
    if 'items' in response and len(response['items']) > 0:
        item = response['items'][0]
        snippet = item['snippet']
        content_details = item['contentDetails']
        statistics = item['statistics']
        tags = snippet.get('tags', [])
        details = {
            'video_id': video_id,
            'title': snippet.get('title'),
            'published_at': snippet.get('publishedAt'),
            'duration': content_details.get('duration'),
            'dimension': content_details.get('dimension'),
            'definition': content_details.get('definition'),
            'view_count': statistics.get('viewCount'),
            'like_count': statistics.get('likeCount'),
            'dislikeCount': statistics.get('dislikeCount'),
            'favorite_count': statistics.get('favoriteCount'),
            'commnent_count': statistics.get('commentCount'),
            'tags': tags,
            'date_extract': today
        }
        return details
    return None

