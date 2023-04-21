import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select-image"
export default class extends Controller {
  static targets = ["image"]

  fileChange(event) {
    const preview = this.imageTarget;
    const file = event.target.files[0];
    const reader = new FileReader();

    reader.readAsDataURL(file);
    reader.addEventListener("load", () => {
      preview.src = reader.result;
    }, false)
  }

  // 複数画像をupできるフォーム
  filesChange(event) {
    const allPreview = document.getElementById("preview_images");
    const newPreview = document.createElement("p");
    // 再度画像を選択した際、前に選択した画像のプレビューを消して新たに作成
    allPreview.querySelector("p").remove();
    newPreview.setAttribute("id", "preview");
    newPreview.classList.add("flex");
    allPreview.insertBefore(newPreview, allPreview.firstChild);
    // displayのstyleをnoneから、表示できるよう変更
    allPreview.style.display = "";
    for (let i = 0; i < event.target.files.length; i++) {
      const reader = new FileReader();
      reader.addEventListener("load", () => {
        let img = new Image();
        img.src = reader.result;
        img.width = 130;
        img.classList.add("p-1");
        document.getElementById('preview').appendChild(img);
      }, false)
      reader.readAsDataURL(event.target.files[i]);
    }
  }
}
