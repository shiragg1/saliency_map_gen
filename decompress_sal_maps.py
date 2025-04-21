#!/usr/bin/env python3

import h5py

def load_hdf5_images(hdf5_path):
    with h5py.File(hdf5_path, "r") as f:
        for class_name in f.keys():
            group = f[class_name]
            for dname in group.keys():
                img = group[dname][:]
                label = group[dname].attrs["label"]
                fname = group[dname].attrs["filename"]
                size = (group[dname].attrs["height"], group[dname].attrs["width"])

                yield {
                    "image": img,
                    "label": label,
                    "filename": fname,
                    "size": size,
                    "class_name": class_name
                }