#!/bin/bash
rclone mount onedrive: ~/onedrive/ --vfs-cache-mode full &
rclone mount ChrisFeedbacks: ~/ChrisFeedbacks/ &
