from extract.extract import extract
from load.load import load
from utils.email import send_emails
import time
def main():
    df = extract()
    load(df)
    send_emails(["thai.pv206303@sis.hust.edu.vn"])

    # df.to_csv('output.csv', index=False, mode='a')
    time.sleep(5)

if __name__ == "__main__":
    main()
