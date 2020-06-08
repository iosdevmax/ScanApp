enum CustomImages {
  add_folder,
  folder,
  select,
  sort_by,
  document, 
  edit_cell,
  delete_cell,
  camera_button,
  library_button,
  automatic_button,
  multipage_button,
  light_button
}

String image(CustomImages url) {
  switch (url) {
    case CustomImages.add_folder: return 'assets/images/add_folder_icon.png';
    case CustomImages.folder: return 'assets/images/folder_icon.png';
    case CustomImages.select: return 'assets/images/select_icon.png';
    case CustomImages.sort_by: return 'assets/images/sort_by_icon.png';
    case CustomImages.document: return 'assets/images/document_icon.png';
    case CustomImages.edit_cell: return 'assets/images/edit_cell_button.png';
    case CustomImages.delete_cell: return 'assets/images/delete_cell_button.png';
    case CustomImages.camera_button: return 'assets/images/camera_button.png';
    case CustomImages.library_button: return 'assets/images/library_button.png';
    case CustomImages.automatic_button: return 'assets/images/automatic_button_image.png';
    case CustomImages.multipage_button: return 'assets/images/multipage_button_image.png';
    case CustomImages.light_button: return 'assets/images/light_button_image.png';
    default: return '';
  }
}