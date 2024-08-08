from extract.api import get_video_details, get_uploads_playlist_id, get_playlist_videos
from utils.authentication.authentication import get_authenticated_service
from datetime import datetime, timedelta
import pandas as pd
          
def extract():
    youtube = get_authenticated_service()
    channel_id = "UCRsd_L7wBGdHLhfacuy3QVw"

    uploads_playlist_id = get_uploads_playlist_id(youtube, channel_id)
    all_videos = get_playlist_videos(youtube, uploads_playlist_id)

    print(f"Total videos: {len(all_videos)}")
    
    video_details_list = []
    for video in all_videos:
        video_id = video
        details = get_video_details(youtube, video_id)
        if details:
            # details['playlist_title'] = video['playlist_title']
            video_details_list.append(details)

    # Tạo dataframe từ danh sách chi tiết video
    df = pd.DataFrame(video_details_list)

    # In ra số lượng video và dataframe
    print(f"Total videos: {len(df)}")
    print(df)

    return df
    