#!/usr/bin/env python3

import os
import numpy as np
from PIL import Image
import h5py
import tqdm

# RGB HDF5 output path
# output_file = "/media/Data/Attention_NN/matlab_models/compressed_data/ImageNette_Train.h5"
output_file = "/media/Data/Attention_NN/matlab_models/compressed_data/ImageNette_Val.h5"

# sal_map_root = "/media/Data/Attention_NN/matlab_models/imagenette2/train"
sal_map_root = "/media/Data/Attention_NN/matlab_models/imagenette2/val"
batches = [
    "n01440764", "n02102040", "n02979186", "n03000684", "n03028079",
    "n03394916", "n03417042", "n03425413", "n03445777", "n03888257"
]

with h5py.File(output_file, "w") as hdf:
    for class_idx, batch in enumerate(batches):
        batch_dir = os.path.join(sal_map_root, batch)
        if not os.path.isdir(batch_dir):
            print(f"Skipping missing folder: {batch_dir}")
            continue

        group = hdf.create_group(batch)
        image_counter = 0

        for fname in tqdm.tqdm(os.listdir(batch_dir), desc=f"Processing {batch}"):
            if not fname.lower().endswith(('.jpg', '.jpeg', '.png')):
                continue

            fpath = os.path.join(batch_dir, fname)
            try:
                img = Image.open(fpath)
                if img.mode != 'RGB':
                    print(f"Skipping non-RGB image: {fname}")
                    continue

                img_np = np.array(img, dtype=np.uint8)  # (H, W, 3)

                dname = f"image_{image_counter:05d}"
                dset = group.create_dataset(dname, data=img_np, compression="gzip")

                dset.attrs["label"] = class_idx
                dset.attrs["filename"] = fname
                dset.attrs["height"], dset.attrs["width"] = img_np.shape[:2]

                image_counter += 1

            except Exception as e:
                print(f"Error processing {fpath}: {e}")