/*
  Animasi Sejarah Migrasi Suku Batak ke Medan (Full Animasi Version)
  Durasi: 3 Menit (180 Detik)
  Resolusi: 1280 x 720
  Bahasa: Java Processing
*/

import processing.sound.*;

boolean enableSound = true; // AUDIO SUDAH DIAKTIFKAN
SoundFile bgm;
SoundFile[] voices = new SoundFile[13];
int lastScene = -1;

int startTime;
int totalDuration = 180000;
int numScenes = 13;
float[] sceneDurations = new float[13];
float[] sceneStartTimes = new float[13];
PFont fontTitle, fontBody;

String[] subtitles = {
  "Sejarah panjang Kota Medan tidak lepas dari kisah pergerakan masyarakatnya. Salah satu gelombang migrasi paling berpengaruh adalah masuknya Suku Batak dari dataran tinggi, menuju pusat peradaban baru.",
  "Pada mulanya, tanah ini adalah rumah bagi masyarakat Melayu Deli. Di bawah naungan Kesultanan Deli yang megah, kebudayaan pesisir tumbuh subur di bawah langit pesisir timur Sumatera.",
  "Kehidupan di tepi sungai berjalan harmonis. Masyarakat Melayu dan Karo pesisir hidup berdampingan secara damai, menggantungkan hidup pada jalur perdagangan air dan kekayaan hasil bumi.",
  "Namun, angin perubahan berhembus ketika bangsa Belanda datang. Kapal-kapal besar bersandar, membawa ambisi imperialisme dan merubah wajah tanah Deli selamanya.",
  "Era baru dimulai. Pembukaan perkebunan tembakau Deli yang mendunia, mengubah lanskap hutan menjadi lautan emas hijau. Kebutuhan akan tenaga kerja pun meningkat drastis.",
  "Untuk menggerakkan roda ekonomi perkebunan, pekerja didatangkan secara masif. Para pekerja dari Tionghoa dan Jawa mulai berdatangan, menjadi fondasi awal masyarakat multietnis di Sumatera Timur.",
  "Dari balik pegunungan Tapanuli, suku Mandailing mulai bermigrasi turun. Mereka adalah salah satu kelompok Batak pertama yang hadir, membawa tradisi, semangat pendidikan, dan niat berniaga.",
  "Daya tarik ekonomi Medan memanggil lebih banyak saudara dari dataran tinggi. Suku Karo, Toba, Simalungun, dan Pakpak merantau, menembus batas wilayah demi kehidupan yang lebih baik.",
  "Memasuki abad ke-20, Medan menjelma menjadi kota multietnis yang semarak. Masjid, Kelenteng, dan Gereja berdiri berdampingan. Keberagaman mulai menjadi nyawa bagi kota ini.",
  "Setelah kemerdekaan, struktur demografi kota perlahan bergeser. Masyarakat Batak dan etnis lainnya semakin mengambil peran penting dalam roda ekonomi dan pemerintahan di Kota Medan.",
  "Puncaknya terjadi pada era delapan puluhan hingga sembilan puluhan. Gelombang urbanisasi besar-besaran Suku Batak Toba memperkaya denyut nadi kota, menguatkan eksistensi mereka di berbagai sektor.",
  "Kini, Medan berdiri sebagai kota metropolitan yang unik. Sebuah kota tanpa satu etnis yang mendominasi mutlak. Setiap suku dan agama saling terhubung, mengisi peran dalam harmoni.",
  "Pada akhirnya, Medan adalah wujud nyata dari rumah bersama yang majemuk. Tempat di mana kita menghormati sejarah masa lalu, dan merayakan keberagaman untuk masa depan. Medan, kota kita bersama."
};

// Palet Warna
color colorBg = color(245, 242, 235);
color colorDarkBlue = color(30, 50, 80);
color colorGold = color(220, 160, 50);
color colorRedBatak = color(170, 30, 40);
color colorGreen = color(40, 110, 70);
color colorBrown = color(130, 80, 50);
color colorText = color(40, 40, 40);

void setup() {
  // size(1280, 720);
  // Menggunakan mode fullscreen agar memenuhi layar monitor sepenuhnya
  fullScreen(); 
  
  smooth(8);
  fontTitle = createFont("SansSerif-Bold", 48);
  fontBody = createFont("SansSerif", 24);
  
  if (enableSound) {
    try {
      // Load dan putar Background Music
      bgm = new SoundFile(this, "bgm.mp3");
      bgm.loop();
      bgm.amp(0.15); // Set volume di kisaran 15% agar pas (terdengar, tapi tidak terlalu keras)
    } catch(Exception e) {
      println("Error loading bgm.mp3. Pastikan file ada di folder 'data'.");
    }
      
    // Load file dubbing untuk tiap scene dan hitung durasi dinamis
    float totalT = 0;
    for(int i = 0; i < numScenes; i++) {
      int fileNumber = i + 1; // Scene ke-1 sampai ke-13
      String fileName = "scene_" + fileNumber + "_m4a.mp3";
      try {
        voices[i] = new SoundFile(this, fileName);
        voices[i].amp(1.0); // Suara dubbing dimaksimalkan (100%)
        
        // Sesuaikan durasi scene dengan durasi file audio (dalam milidetik) + jeda 0.5 detik
        sceneDurations[i] = (voices[i].duration() * 1000.0) + 500.0;
      } catch(Exception e) {
        println("Gagal load " + fileName);
        sceneDurations[i] = 13846; // Durasi default jika file hilang
      }
      
      // Simpan waktu mulai untuk scene ini
      sceneStartTimes[i] = totalT;
      totalT += sceneDurations[i];
    }
    // Update total durasi seluruh animasi agar menyesuaikan dengan panjang total audio
    totalDuration = (int)totalT;
  } else {
    // Jika suara dimatikan, bagi durasi secara rata
    float defaultDur = 180000.0 / numScenes;
    for(int i = 0; i < numScenes; i++) {
      sceneDurations[i] = defaultDur;
      sceneStartTimes[i] = i * defaultDur;
    }
  }
  
  startTime = millis();
}

void draw() {
  background(colorBg);
  
  int elapsed = millis() - startTime;
  if (elapsed > totalDuration) {
    elapsed = totalDuration; 
  }
  
  // Mencari scene mana yang sedang aktif berdasarkan durasi suara dubbing
  int currentScene = numScenes - 1;
  for (int i = 0; i < numScenes; i++) {
    if (elapsed >= sceneStartTimes[i] && elapsed < sceneStartTimes[i] + sceneDurations[i]) {
      currentScene = i;
      break;
    }
  }
  
  float currentSceneElapsed = elapsed - sceneStartTimes[currentScene];
  float sceneTime = currentSceneElapsed / sceneDurations[currentScene]; 
  
  // Logika memutar dubbing audio saat scene berganti
  if (currentScene != lastScene) {
    if (enableSound) {
      // Hentikan suara scene sebelumnya jika masih berjalan
      if (lastScene >= 0 && voices[lastScene] != null) {
        voices[lastScene].stop(); 
      }
      // Putar suara scene baru
      if (voices[currentScene] != null) {
        voices[currentScene].play();
      }
    }
    lastScene = currentScene;
  }
  
  float alphaValue = 255;
  float fadeMargin = 0.08; 
  if (sceneTime < fadeMargin) {
    alphaValue = map(sceneTime, 0, fadeMargin, 0, 255);
  } else if (sceneTime > 1.0 - fadeMargin) {
    alphaValue = map(sceneTime, 1.0 - fadeMargin, 1.0, 255, 0);
  }
  
  pushStyle();
  switch(currentScene) {
    case 0: drawScene1(sceneTime, alphaValue); break;
    case 1: drawScene2(sceneTime, alphaValue); break;
    case 2: drawScene3(sceneTime, alphaValue); break;
    case 3: drawScene4(sceneTime, alphaValue); break;
    case 4: drawScene5(sceneTime, alphaValue); break;
    case 5: drawScene6(sceneTime, alphaValue); break;
    case 6: drawScene7(sceneTime, alphaValue); break;
    case 7: drawScene8(sceneTime, alphaValue); break;
    case 8: drawScene9(sceneTime, alphaValue); break;
    case 9: drawScene10(sceneTime, alphaValue); break;
    case 10: drawScene11(sceneTime, alphaValue); break;
    case 11: drawScene12(sceneTime, alphaValue); break;
    case 12: drawScene13(sceneTime, alphaValue); break;
  }
  popStyle();
  
  // Tampilkan Subtitle
  drawSubtitle(currentScene, alphaValue);
  
  // Progress Bar
  noStroke();
  fill(200);
  rect(0, height - 10, width, 10);
  fill(colorRedBatak);
  rect(0, height - 10, map(elapsed, 0, totalDuration, 0, width), 10);
}

// ======================== FUNGSI HELPER MENGGAMBAR ========================

void drawPerson(float x, float y, float scl, boolean isBatak, color c, float time, float alpha) {
  pushMatrix();
  
  // Efek memantul (bouncing) saat berjalan
  float bounce = abs(sin(time * TWO_PI * 6)) * 5;
  translate(x, y - bounce);
  scale(scl);
  
  float walkSwing = sin(time * TWO_PI * 6) * 25; 
  
  noStroke();
  
  // Lengan Kiri Belakang (Berlawanan arah dengan kaki kiri, lebih gelap)
  fill(color(red(c)*0.7, green(c)*0.7, blue(c)*0.7), alpha);
  pushMatrix();
  translate(0, -45);
  rotate(radians(-walkSwing));
  rect(-4, 0, 8, 35, 4);
  popMatrix();

  // Kaki Kiri
  fill(color(red(c)*0.7, green(c)*0.7, blue(c)*0.7), alpha);
  pushMatrix();
  translate(-6, -10);
  rotate(radians(walkSwing));
  rect(-4, 0, 8, 30, 4);
  popMatrix();
  
  // Kaki Kanan (Depan)
  fill(c, alpha);
  pushMatrix();
  translate(6, -10);
  rotate(radians(-walkSwing));
  rect(-4, 0, 8, 30, 4);
  popMatrix();
  
  // Badan
  fill(c, alpha);
  rect(-14, -50, 28, 45, 8);
  
  // Kepala
  ellipse(0, -65, 30, 30);
  
  // Lengan Kanan Depan
  fill(c, alpha);
  pushMatrix();
  translate(0, -45);
  rotate(radians(walkSwing));
  rect(-4, 0, 8, 35, 4);
  popMatrix();
  
  // Aksesoris Batak
  if (isBatak) {
    fill(colorRedBatak, alpha);
    arc(0, -70, 32, 15, PI, TWO_PI); // Sortali
    pushMatrix();
    rotate(radians(30));
    rect(-5, -45, 10, 45, 2); // Ulos
    popMatrix();
  }
  
  popMatrix();
}

void drawText(String title, String subtitle, float alpha) {
  drawTextCustom(title, subtitle, alpha, 48, 24);
}

void drawTextCustom(String title, String subtitle, float alpha, float sizeT, float sizeS) {
  textAlign(CENTER, TOP);
  fill(colorText, alpha);
  textFont(fontTitle, sizeT);
  text(title, width/2, 60);
  textFont(fontBody, sizeS);
  fill(colorRedBatak, alpha);
  text(subtitle, width/2, 60 + sizeT + 10);
}

void drawClouds(float t, float a) {
  fill(255, 255, 255, a * 0.7);
  noStroke();
  for (int i = 0; i < 5; i++) {
    float cx = ((i * 300) + (t * 200)) % (width + 300) - 150;
    float cy = 150 + sin(i * 10 + t * TWO_PI) * 20;
    ellipse(cx, cy, 120, 60);
    ellipse(cx - 40, cy + 10, 80, 50);
    ellipse(cx + 40, cy + 15, 90, 50);
  }
}

void drawSun(float t, float a) {
  pushMatrix();
  translate(width - 250, 180); // Posisi matahari di kanan atas
  rotate(t * TWO_PI * 0.2); // Berputar perlahan
  
  noStroke();
  // Glow effect
  for(int i = 4; i > 0; i--) {
    fill(255, 220, 100, a * (0.1 * i));
    ellipse(0, 0, 100 + (i * 30), 100 + (i * 30));
  }
  
  // Inti Matahari
  fill(255, 250, 180, a);
  ellipse(0, 0, 100, 100);
  popMatrix();
}

void drawMoon(float t, float a) {
  pushMatrix();
  translate(250, 180); // Posisi bulan di kiri atas
  
  noStroke();
  // Glow effect
  for(int i = 4; i > 0; i--) {
    fill(200, 220, 255, a * (0.05 * i));
    ellipse(0, 0, 80 + (i * 20), 80 + (i * 20));
  }
  
  // Inti Bulan Purnama
  fill(240, 245, 255, a);
  ellipse(0, 0, 80, 80);
  
  popMatrix();
}

void drawSubtitle(int sceneIndex, float alphaValue) {
  if (sceneIndex >= 0 && sceneIndex < 13) {
    String textSub = subtitles[sceneIndex];
    
    pushStyle();
    rectMode(CENTER);
    fill(0, 0, 0, alphaValue * 0.6); // Background hitam transparan
    noStroke();
    
    float boxWidth = width * 0.85;
    float boxHeight = 100;
    float boxY = height - 80;
    
    rect(width/2, boxY, boxWidth, boxHeight, 15); // Kotak rounded
    
    fill(255, 255, 255, alphaValue);
    textAlign(CENTER, CENTER);
    textFont(fontBody, 22);
    
    // Text wrap
    rectMode(CORNER);
    text(textSub, width/2 - boxWidth/2 + 30, boxY - boxHeight/2 + 10, boxWidth - 60, boxHeight - 20);
    popStyle();
  }
}

void drawBirds(float t, float a) {
  fill(50, a * 0.8);
  noStroke();
  for (int i = 0; i < 6; i++) {
    float bx = (width + 100) - (((t * 400) + i * 80) % (width + 200));
    float by = 200 + sin(t * TWO_PI * 4 + i) * 30 - i * 15;
    
    pushMatrix();
    translate(bx, by);
    float wingSurge = sin(t * TWO_PI * 15 + i) * 10;
    beginShape();
    vertex(0, 0);
    vertex(-10, -5 - wingSurge);
    vertex(-5, 0);
    vertex(-15, -3 - wingSurge/2);
    vertex(0, 5);
    endShape(CLOSE);
    popMatrix();
  }
}

// ======================== SCENES ========================

void drawScene1(float t, float a) {
  // Latar Langit
  for (int y = 0; y < height/2 + 100; y++) {
    float inter = map(y, 0, height/2+100, 0, 1);
    color c = lerpColor(color(180, 220, 240, a), colorBg, inter);
    stroke(c);
    line(0, y, width, y);
  }
  
  drawSun(t, a);
  drawClouds(t, a);
  drawBirds(t, a);
  
  drawTextCustom("MASUKNYA SUKU BATAK", "KE MEDAN", a, 48, 24);
  
  float yBase = height - 150;
  noStroke();
  
  // Siluet Rumah Adat Batak (Rumah Bolon)
  
  // Tangga kayu di bawah
  fill(color(red(colorDarkBlue)*0.5, green(colorDarkBlue)*0.5, blue(colorDarkBlue)*0.5), a * 0.7);
  rect(width/2 - 15, yBase - 40, 30, 40);
  
  fill(colorDarkBlue, a * 0.7);
  
  // Tiang-tiang penyangga khas rumah panggung
  for(int i = -100; i <= 100; i += 40) {
    if (i != 0) { // Lewati tengah untuk tangga
      rect(width/2 + i - 5, yBase - 30, 10, 30);
    }
  }
  
  // Badan rumah (Trapesium terbalik)
  beginShape();
  vertex(width/2 - 130, yBase - 80);
  vertex(width/2 + 130, yBase - 80);
  vertex(width/2 + 110, yBase - 30);
  vertex(width/2 - 110, yBase - 30);
  endShape(CLOSE);
  
  // Atap Ijuk Melengkung (Saddle Roof)
  beginShape();
  vertex(width/2 - 140, yBase - 80); // Kiri bawah
  vertex(width/2 - 220, yBase - 280); // Pucuk kiri atas (Sangat tinggi)
  
  // Lengkungan atas atap (Melengkung ke dalam)
  bezierVertex(width/2 - 80, yBase - 150, width/2 + 80, yBase - 150, width/2 + 220, yBase - 280); 
  
  vertex(width/2 + 140, yBase - 80); // Kanan bawah
  
  // Lengkungan bawah atap
  bezierVertex(width/2 + 80, yBase - 120, width/2 - 80, yBase - 120, width/2 - 140, yBase - 80);
  endShape(CLOSE);
  
  // Fasad Segitiga Depan (Jabu)
  fill(color(red(colorDarkBlue)*0.6, green(colorDarkBlue)*0.6, blue(colorDarkBlue)*0.6), a * 0.7);
  triangle(width/2, yBase - 190, width/2 - 80, yBase - 80, width/2 + 80, yBase - 80);
  
  // Ornamen Gorga / Jendela kecil di fasad
  fill(colorBg, a * 0.6);
  ellipse(width/2, yBase - 130, 20, 20);
  triangle(width/2, yBase - 160, width/2 - 10, yBase - 145, width/2 + 10, yBase - 145);
  
  for(int i = 0; i < 5; i++) {
    float px = (width/2 - 200 + i*100) + sin(t*TWO_PI + i)*30;
    boolean isBatak = (i % 2 == 0);
    drawPerson(px, yBase, 1.2, isBatak, color(100, a), t, a);
  }
}

void drawScene2(float t, float a) {
  // Langit Malam Berbintang
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(color(10, 20, 40, a), color(40, 60, 90, a), inter);
    stroke(c);
    line(0, y, width, y);
  }
  
  // Bintang kelip (menggunakan pseudo-random deterministik)
  noStroke();
  for(int i=0; i<100; i++) {
    float sx = (i * 97) % width;
    float sy = (i * 53) % height;
    float twinkle = abs(sin(t * TWO_PI * (1+(i%4)) + i));
    fill(255, 255, 200, a * twinkle);
    ellipse(sx, sy, 3, 3);
  }
  
  drawMoon(t, a);
  drawClouds(t * 0.3, a * 0.2); // Awan malam tipis
  
  drawText("Tanah Melayu Deli & Kesultanan Deli", "Wilayah asli sebelum kedatangan suku lain", a);
  
  float yBase = height - 120;
  float mX = width/2;
  float mY = yBase;
  
  // Bangunan Utama (Dasar)
  fill(colorDarkBlue, a);
  rect(mX - 250, mY - 120, 500, 120, 10, 10, 0, 0);
  // Sayap Kiri Kanan
  rect(mX - 350, mY - 80, 100, 80, 5, 5, 0, 0);
  rect(mX + 250, mY - 80, 100, 80, 5, 5, 0, 0);

  // Menara (Minarets)
  rect(mX - 320, mY - 200, 30, 200, 3, 3, 0, 0);
  rect(mX + 290, mY - 200, 30, 200, 3, 3, 0, 0);
  // Kubah Kecil Menara
  fill(colorGold, a);
  arc(mX - 305, mY - 200, 40, 40, PI, TWO_PI);
  arc(mX + 305, mY - 200, 40, 40, PI, TWO_PI);
  
  // Bangunan Tengah (Lebih tinggi)
  fill(colorDarkBlue, a);
  rect(mX - 120, mY - 180, 240, 60);

  // Kubah Utama Tengah & Pendamping
  fill(colorGold, a);
  arc(mX, mY - 180, 180, 180, PI, TWO_PI);
  arc(mX - 160, mY - 120, 100, 100, PI, TWO_PI);
  arc(mX + 160, mY - 120, 100, 100, PI, TWO_PI);

  // Pintu/Lengkungan Bercahaya
  fill(color(255, 240, 150), a * 0.8);
  for(int i = -3; i <= 3; i++) {
    if (i == 0) {
      rect(mX - 30, mY - 80, 60, 80);
      arc(mX, mY - 80, 60, 60, PI, TWO_PI);
    } else {
      float px = mX + i * 70;
      rect(px - 20, mY - 60, 40, 60);
      arc(px, mY - 60, 40, 40, PI, TWO_PI);
    }
  }

  // Bulan Sabit Glow di Pucuk Kubah Utama
  pushMatrix();
  float moonY = mY - 300 + sin(t*TWO_PI)*10;
  translate(mX, moonY);
  fill(255, 200, 50, a * 0.2);
  ellipse(0, 0, 60, 60); 
  fill(colorGold, a);
  arc(0, 0, 40, 40, HALF_PI, PI+HALF_PI);
  // Potong bulan dengan warna langit malam di ketinggian tersebut
  fill(lerpColor(color(10, 20, 40, a), color(40, 60, 90, a), 0.2)); 
  arc(10, 0, 40, 40, HALF_PI, PI+HALF_PI);
  popMatrix();
}

void drawScene3(float t, float a) {
  // Langit pagi
  background(lerpColor(color(255, 230, 200, a), colorBg, 0.5));
  drawSun(t, a);
  drawClouds(t * 0.5, a);
  drawBirds(t * 0.8, a);
  
  drawText("Kehidupan Melayu Deli & Karo Pesisir", "Hidup berdampingan dari perdagangan dan pertanian", a);
  
  // Ombak Sungai Berlapis (Parallax)
  noStroke();
  float baseWaterY = height - 200;
  
  fill(80, 160, 180, a);
  rect(0, baseWaterY, width, 200);
  
  for(int j=0; j<3; j++) {
    fill(lerpColor(color(80, 160, 180, a), color(40, 100, 120, a), j/2.0));
    beginShape();
    vertex(0, height);
    for(int x=0; x<=width+50; x+=50) {
      float y = baseWaterY + (j*30) + sin(t*TWO_PI*2 + x*0.02 + j)*15;
      vertex(x, y);
    }
    vertex(width, height);
    endShape(CLOSE);
  }
  
  // Rumah Panggung
  pushMatrix();
  translate(width/4, height - 250);
  fill(colorBrown, a);
  rect(-60, 0, 10, 120); 
  rect(50, 0, 10, 120);  
  fill(colorRedBatak, a);
  triangle(-90, -80, 90, -80, 0, -160); 
  fill(colorGold, a);
  rect(-70, -80, 140, 80); 
  popMatrix();
  
  // Perahu Mendayung
  pushMatrix();
  float boatX = width/2 + 200 + sin(t * TWO_PI)*100;
  float boatY = height - 100 + cos(t * TWO_PI * 2)*15;
  translate(boatX, boatY);
  rotate(radians(sin(t * TWO_PI)*10)); 
  
  fill(colorGreen, a);
  arc(0, 0, 140, 70, 0, PI);
  
  drawPerson(-20, -10, 0.8, false, colorDarkBlue, 0, a);
  
  // Dayung berayun
  stroke(colorBrown, a);
  strokeWeight(4);
  float oarAngle = sin(t * TWO_PI * 4) * 30 + 45;
  pushMatrix();
  translate(-10, -30);
  rotate(radians(oarAngle));
  line(0, -20, 0, 60);
  popMatrix();
  noStroke();
  popMatrix();
}

void drawScene4(float t, float a) {
  // Latar Laut & Langit Dinamis
  background(lerpColor(color(150, 200, 255, a), colorBg, 0.5));
  drawSun(t, a);
  drawClouds(t * 1.5, a);
  
  drawText("Kedatangan Belanda", "Membuka perkebunan skala besar", a);
  
  float baseWaterY = height/2 + 50;
  
  // Ombak Laut
  noStroke();
  for(int j=0; j<4; j++) {
    fill(lerpColor(color(60, 130, 180, a), color(20, 70, 110, a), j/3.0));
    beginShape();
    vertex(0, height);
    for(int x=0; x<=width+50; x+=50) {
      float y = baseWaterY + (j*40) + sin(t*TWO_PI*3 + x*0.01 - j)*20;
      vertex(x, y);
    }
    vertex(width, height);
    endShape(CLOSE);
  }
  
  // Kapal melaju
  float shipX = map(t, 0, 1, -300, width + 300);
  float shipY = height/2 + 30 + sin(t*TWO_PI*4)*15;
  
  pushMatrix();
  translate(shipX, shipY);
  rotate(radians(sin(t*TWO_PI*2)*5)); // Kapal bergoyang
  
  fill(colorBrown, a);
  beginShape();
  vertex(-120, 0); vertex(120, 0); vertex(90, 50); vertex(-90, 50);
  endShape(CLOSE);
  
  // Layar melengkung tertiup angin
  stroke(100, a); strokeWeight(6);
  line(0, 0, 0, -180); 
  noStroke();
  fill(250, a);
  beginShape();
  vertex(0, -170);
  bezierVertex(60, -170, 100, -100, 80, -30);
  vertex(0, -30);
  endShape(CLOSE);
  
  // Asap Cerobong kecil dinamis
  fill(80, a * 0.6);
  for(int i=0; i<5; i++) {
    float sx = -60 - ((t*100 + i*20)%80);
    float sy = -40 - ((t*100 + i*20)%80);
    float ss = 10 + ((t*100 + i*20)%80);
    ellipse(sx, sy, ss, ss);
  }
  fill(30, a);
  rect(-70, -40, 20, 40);
  
  popMatrix();
}

void drawScene5(float t, float a) {
  // Latar Belakang (Langit Gradien)
  for (int y = 0; y < height/2; y++) {
    float inter = map(y, 0, height/2, 0, 1);
    color c = lerpColor(color(255, 220, 150, a), colorBg, inter);
    stroke(c);
    line(0, y, width, y);
  }
  noStroke();
  
  fill(color(255, 140, 50, a));
  ellipse(width/2, height/2 - 40 + sin(t*PI)*20, 150, 150);
  
  fill(color(120, 150, 110, a));
  beginShape();
  vertex(0, height/2); vertex(0, height/2 - 60);
  bezierVertex(width/4, height/2 - 150, width/2, height/2 - 20, width, height/2 - 100);
  vertex(width, height/2);
  endShape(CLOSE);

  fill(color(160, 110, 70, a));
  rect(0, height/2, width, height/2);

  float vpX = width/2;
  float vpY = height/2;
  
  stroke(color(130, 85, 50, a));
  strokeWeight(4);
  for(int i=-15; i<=15; i++) {
    line(vpX, vpY, vpX + i*250, height);
  }
  noStroke();
  
  for(int j=1; j<=20; j++) {
    for(int i=-8; i<=8; i++) {
      float progress = ((t * 4) + (j / 20.0)) % 1.0; 
      float px = lerp(vpX, vpX + i*300, progress);
      float py = lerp(vpY, height + 150, progress);
      float scalePlant = map(progress, 0, 1, 0.05, 4.0);
      
      if (scalePlant < 0.1 || py > height + 100) continue;
      
      pushMatrix();
      translate(px, py);
      scale(scalePlant);
      
      stroke(color(40, 80, 30, a));
      strokeWeight(2);
      line(0, 0, 0, -25);
      
      noStroke();
      fill(color(70, 140, 60, a));
      beginShape();
      vertex(0, -5); bezierVertex(-20, -10, -35, 5, -40, 15); bezierVertex(-20, 15, -10, 5, 0, -5);
      endShape(CLOSE);
      
      fill(color(60, 130, 50, a));
      beginShape();
      vertex(0, -10); bezierVertex(20, -15, 35, 0, 40, 10); bezierVertex(20, 10, 10, 0, 0, -10);
      endShape(CLOSE);
      
      fill(color(90, 160, 80, a));
      beginShape();
      vertex(0, -25); bezierVertex(-15, -20, -5, -5, 0, 0); bezierVertex(5, -5, 15, -20, 0, -25);
      endShape(CLOSE);
      
      popMatrix();
    }
  }
  drawText("Perkebunan Tembakau Sumatera Timur", "Awal mula gelombang migrasi pekerja", a);
}

void drawScene6(float t, float a) {
  // Latar Hutan/Pohon Karet (Parallax Scrolling)
  background(colorBg);
  
  // Layer Belakang (Lambat)
  fill(color(80, 130, 90, a * 0.5));
  for(int i=0; i<15; i++) {
    float px = ((i * 150) - (t * 200)) % (width + 300) - 150;
    rect(px, height - 300, 20, 200);
    ellipse(px + 10, height - 300, 100, 100);
  }
  
  // Layer Tengah (Sedang)
  fill(color(50, 100, 60, a * 0.7));
  for(int i=0; i<10; i++) {
    float px = ((i * 200) - (t * 400)) % (width + 300) - 150;
    rect(px, height - 250, 30, 250);
    ellipse(px + 15, height - 250, 130, 130);
  }

  // Tanah
  fill(color(120, 80, 50, a));
  rect(0, height - 100, width, 100);
  
  drawSun(t, a);
  
  drawText("Gelombang Pekerja Tionghoa & Jawa", "Didatangkan secara masif untuk perkebunan", a);
  
  float yBase = height - 60;
  for(int i=0; i<8; i++) {
    float startX = -300 + (i * 150);
    float x = startX + (t * 900); // Bergerak cepat ke kanan
    color c = (i%2==0) ? colorDarkBlue : colorGold; 
    drawPerson(x, yBase, 1.2, false, c, t, a);
  }
}

void drawScene7(float t, float a) {
  // Pegunungan Tapanuli (Lebih Indah)
  background(lerpColor(color(200, 230, 255, a), colorBg, 0.5));
  drawSun(t, a);
  drawClouds(t * 0.5, a);
  
  drawText("Kehadiran Awal Suku Mandailing", "Bermigrasi dari Tapanuli Selatan", a);
  
  // Gunung Belakang
  fill(color(120, 160, 140, a * 0.8));
  triangle(0, height, 300, 150, 700, height);
  triangle(400, height, 800, 200, 1200, height);
  
  // Kabut Pegunungan
  fill(255, 255, 255, a * 0.5);
  noStroke();
  for(int x=0; x<width; x+=100) {
    float y = 300 + sin(t*TWO_PI + x*0.01)*50;
    ellipse(x + (t*100)%100, y, 300, 100);
  }
  
  // Gunung Depan
  fill(color(80, 120, 90, a));
  beginShape();
  vertex(0, height); vertex(0, 400);
  bezierVertex(200, 300, 400, 500, 600, 450);
  bezierVertex(800, 400, 1000, 600, width, 500);
  vertex(width, height);
  endShape(CLOSE);
  
  // Path berliku
  noFill();
  stroke(color(200, 150, 100, a));
  strokeWeight(20);
  beginShape();
  curveVertex(100, 400); curveVertex(100, 400);
  curveVertex(350, 480); curveVertex(650, 430);
  curveVertex(900, 600); curveVertex(1150, height + 50);
  curveVertex(1150, height + 50);
  endShape();
  noStroke();
  
  // Orang Mandailing
  float progress = t; 
  float px = bezierPoint(100, 350, 900, 1150, progress);
  float py = bezierPoint(400, 480, 600, height, progress) - 20;
  
  drawPerson(px, py, 1.4, true, colorRedBatak, t*1.5, a);
}

void drawScene8(float t, float a) {
  background(lerpColor(color(150, 190, 220, a), colorBg, 0.5)); // Langit cerah
  
  drawMoon(t, a); // Suasana senja / malam
  
  float centerX = width/2;
  float centerY = height/2 + 50;
  
  // Siluet kota Medan Glow
  fill(255, 255, 200, a * 0.15);
  ellipse(centerX, centerY, 400, 400); // Glow aura membesar
  
  fill(colorDarkBlue, a);
  // Tiga Gedung (Diperbesar)
  rect(centerX - 140, centerY - 120, 80, 160, 5);
  rect(centerX - 45, centerY - 180, 100, 220, 5);
  rect(centerX + 70, centerY - 90, 70, 130, 5);
  
  // Jendela kelip di seluruh gedung
  fill(255, 255, 150, a);
  for(int i=0; i<60; i++) {
    float seedVal = (i * 77) % 60;
    if(seedVal % 3 == 0 || sin(t*TWO_PI*2 + i) > 0.5) {
      float wx = 0;
      float wy = 0;
      if (i < 20) { // Gedung Kiri
        wx = centerX - 130 + ((i * 13) % 60);
        wy = centerY - 100 + ((i * 17) % 120);
      } else if (i < 45) { // Gedung Tengah
        wx = centerX - 35 + ((i * 23) % 80);
        wy = centerY - 160 + ((i * 31) % 180);
      } else { // Gedung Kanan
        wx = centerX + 80 + ((i * 37) % 50);
        wy = centerY - 70 + ((i * 41) % 90);
      }
      rect(wx, wy, 5, 8);
    }
  }
  
  float[][] origins = {
    {50, 150}, {150, height-50}, {width-50, 150}, {width-150, height-50}
  };
  
  for(int i=0; i<4; i++) {
    // Garis lintasan bercahaya
    strokeWeight(6);
    for(float p=0; p<=1; p+=0.05) {
      if ((p*20 + t*30) % 2 < 1) {
        stroke(colorRedBatak, a * (1-p)); 
        float lx = lerp(origins[i][0], centerX, p);
        float ly = lerp(origins[i][1], centerY, p);
        point(lx, ly);
      }
    }
    noStroke();
    
    // Orang yang berjalan
    float progress = (t + (i * 0.25)) % 1.0;
    float px = lerp(origins[i][0], centerX, progress);
    float py = lerp(origins[i][1], centerY, progress);
    float scl = map(progress, 0, 1, 1.2, 0.4);
    
    drawPerson(px, py, scl, true, colorRedBatak, t*2, a);
  }
  
  drawText("Migrasi Karo, Toba, Simalungun & Pakpak", "Menuju pusat ekonomi baru di Medan", a);
}

void drawScene9(float t, float a) {
  drawText("Awal Abad 20: Kota Multietnis", "Berbagai rumah ibadah dan komunitas berdampingan", a);
  
  float yBase = height - 150;
  float spacing = width / 5;
  float popT = min(t * 3, 1.0); 
  float scaleY = sin(popT * HALF_PI);
  
  pushMatrix();
  translate(0, yBase);
  scale(1, scaleY);
  
  drawSun(t, a);
  
  // Ornamen dinamis (awan kecil & burung di kota)
  drawClouds(t*0.5, a*0.3);
  drawBirds(t*2, a);
  
  // Masjid
  fill(colorGreen, a);
  rect(spacing*1 - 60, -160, 120, 160, 10, 10, 0, 0);
  fill(colorGold, a);
  arc(spacing*1, -160, 110, 110, PI, TWO_PI);
  // Bendera bulan sabit kecil memutar
  pushMatrix();
  translate(spacing*1, -230); rotate(radians(sin(t*TWO_PI*4)*15));
  fill(colorRedBatak, a); ellipse(0,0,15,15); fill(colorBg); ellipse(3,0,15,15);
  popMatrix();
  
  // Kelenteng
  fill(colorRedBatak, a);
  rect(spacing*2 - 70, -120, 140, 120);
  fill(colorGold, a);
  triangle(spacing*2 - 90, -120, spacing*2 + 90, -120, spacing*2, -200);
  // Lampion bergoyang
  fill(255,0,0, a);
  float lanRot = radians(sin(t*TWO_PI*3)*20);
  pushMatrix(); translate(spacing*2 - 70, -120); rotate(lanRot); rect(-5, 0, 10, 20, 3); popMatrix();
  pushMatrix(); translate(spacing*2 + 70, -120); rotate(lanRot); rect(-5, 0, 10, 20, 3); popMatrix();
  
  // Gereja
  fill(colorDarkBlue, a);
  rect(spacing*3 - 50, -200, 100, 200);
  fill(colorGold, a);
  rect(spacing*3 - 5, -260, 10, 50);
  rect(spacing*3 - 25, -240, 50, 10);
  
  // Rumah Adat
  fill(colorBrown, a);
  rect(spacing*4 - 60, -100, 120, 100);
  fill(colorRedBatak, a);
  beginShape();
  vertex(spacing*4 - 60, -100); vertex(spacing*4 - 100, -190);
  vertex(spacing*4, -150); vertex(spacing*4 + 100, -190);
  vertex(spacing*4 + 60, -100);
  endShape(CLOSE);
  popMatrix();
  
  // Karakter (Berjalan hilir mudik)
  for(int i=1; i<=4; i++) {
    boolean isBatak = (i == 4);
    color c = (i == 1) ? colorGreen : (i == 2) ? colorGold : (i == 3) ? colorDarkBlue : colorRedBatak;
    // Animasi jalan bolak balik
    float walkX = spacing*i + sin(t*TWO_PI + i)*40;
    drawPerson(walkX, yBase + 50, 0.9, isBatak, c, t, a);
  }
}

void drawScene10(float t, float a) {
  drawText("Pasca Kemerdekaan", "Pergeseran proporsi demografi perlahan", a);
  
  float cx = width/2;
  float cy = height/2 + 50;
  float radius = 350;
  
  float pMelayu = lerp(180, 60, t);  
  float pBatak = lerp(60, 150, t);
  float pLain = 360 - (pMelayu + pBatak);
  
  float angle1 = radians(pMelayu);
  float angle2 = angle1 + radians(pBatak);
  
  pushMatrix();
  translate(cx, cy);
  rotate(t * TWO_PI * 0.2); 
  
  noStroke();
  fill(colorGold, a); arc(0, 0, radius, radius, 0, angle1);
  fill(colorRedBatak, a); arc(0, 0, radius, radius, angle1, angle2);
  fill(colorDarkBlue, a); arc(0, 0, radius, radius, angle2, TWO_PI);
  
  // Partikel melayang di tengah
  fill(255, 255, 255, a * 0.5);
  for(int i=0; i<20; i++) {
    float pr = radius/2 + sin(t*TWO_PI*2+i)*(radius/2);
    float pt = t*TWO_PI + i;
    ellipse(cos(pt)*pr, sin(pt)*pr, 5, 5);
  }
  popMatrix();
  
  // Legend Panel Glow
  fill(255, 255, 255, a * 0.8);
  rect(cx + 220, cy - 80, 250, 160, 10);
  textAlign(LEFT, CENTER);
  textFont(fontBody);
  fill(colorGold, a); rect(cx + 240, cy - 50, 20, 20); text("Melayu Deli", cx + 270, cy - 40);
  fill(colorRedBatak, a); rect(cx + 240, cy, 20, 20); text("Suku Batak", cx + 270, cy + 10);
  fill(colorDarkBlue, a); rect(cx + 240, cy + 50, 20, 20); text("Etnis Lain", cx + 270, cy + 60);
}

void drawScene11(float t, float a) {
  drawText("Gelombang Besar Batak Toba (1980-1990an)", "Migrasi masif yang memperkaya budaya", a);
  
  // Latar Belakang Gedung Perkotaan (Lebih Rapi & Menarik)
  fill(colorDarkBlue, a * 0.4);
  rect(60, 300, 200, 500, 8);
  rect(300, 180, 240, 600, 8);
  rect(580, 380, 180, 450, 8);
  rect(800, 150, 220, 650, 8);
  rect(1060, 280, 160, 520, 8);
  
  // Jendela Gedung Latar Belakang
  fill(255, 255, 150, a * 0.6);
  for(int i=0; i<80; i++) {
    float seedVal = (i * 77) % 80;
    if(seedVal % 2 == 0) {
      float wx = 80 + ((i * 37) % 1100);
      float wy = 180 + ((i * 41) % 500);
      
      // Hanya gambar jendela di area gedung
      if ((wx > 70 && wx < 250 && wy > 320) ||
          (wx > 310 && wx < 530 && wy > 200) ||
          (wx > 590 && wx < 750 && wy > 400) ||
          (wx > 810 && wx < 1010 && wy > 170) ||
          (wx > 1070 && wx < 1210 && wy > 300)) {
         rect(wx, wy, 6, 10);
      }
    }
  }
  
  float yBase = height - 100;
  float barWidth = 60;
  float spacing = 120;
  
  for(int i=0; i<8; i++) {
    float maxH = 50 + (i * 45); 
    float progress = constrain((t * 8) - i, 0, 1.0);
    float elasticProgress = progress < 1 ? sin(progress * HALF_PI) : 1; 
    float currentH = maxH * elasticProgress;
    
    // Bar gradient
    for(float y=0; y<currentH; y+=5) {
      float inter = map(y, 0, currentH, 0, 1);
      fill(lerpColor(colorDarkBlue, colorRedBatak, inter), a);
      rect(150 + (i*spacing), yBase - y - 5, barWidth, 5);
    }
    
    // Partikel debu / ledakan saat grafik tumbuh
    if (progress > 0.1 && progress < 0.9) {
      fill(colorGold, a);
      for(int k=0; k<5; k++) {
        float px = 150 + (i*spacing) + barWidth/2 + sin(t*100 + k)*30;
        float py = yBase - currentH + cos(t*100 + k + i)*20;
        ellipse(px, py, 4, 4);
      }
    }
    
    if (currentH > 0 && currentH < maxH) {
      drawPerson(150 + (i*spacing) + barWidth/2, yBase - currentH, 0.7, true, colorGold, t*2, a);
    } else if (currentH == maxH) {
      drawPerson(150 + (i*spacing) + barWidth/2, yBase - currentH, 0.7, true, colorGold, 0, a);
    }
  }
}

void drawScene12(float t, float a) {
  drawText("Kota Tanpa Mayoritas Tunggal", "Beragam etnis hidup berdampingan di Medan", a);
  
  // Cahaya sorot (Spotlights)
  fill(255, 255, 200, a * 0.15);
  noStroke();
  beginShape(); vertex(width/2 - 200, -50); vertex(width/2 + 200, -50); vertex(width, height); vertex(0, height); endShape(CLOSE);
  
  float yBase = height/2 + 100;
  int numPeople = 9;
  float spacing = 100;
  float startX = (width - (numPeople-1)*spacing) / 2;
  
  color[] colors = {colorGold, colorRedBatak, colorDarkBlue, colorGreen, colorBrown};
  
  for(int i=0; i<numPeople; i++) {
    float px = startX + i*spacing;
    float py = yBase + sin((t*TWO_PI*2) + i)*20; 
    
    boolean isBatak = (i%3 == 1);
    drawPerson(px, py, 1.1, isBatak, colors[i%colors.length], t, a);
    
    if (i < numPeople - 1) {
      stroke(180, a);
      strokeWeight(6);
      float nextPy = yBase + sin((t*TWO_PI*2) + (i+1))*20;
      line(px+25, py-50, px+spacing-25, nextPy-50);
      noStroke();
    }
  }
}

void drawScene13(float t, float a) {
  // Latar belakang gradasi meriah
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(color(255, 240, 200, a), colorBg, inter);
    stroke(c);
    line(0, y, width, y);
  }
  noStroke();
  
  drawText("Rumah Bersama yang Majemuk", "Menghormati sejarah, merayakan keberagaman", a);
  
  float cx = width/2;
  float cy = height/2 + 50;
  
  float offset = map(min(t*2, 1.0), 0, 1, 400, 80);
  
  blendMode(MULTIPLY); 
  
  // Pulsing effect saat sudah menyatu
  float pulse = t > 0.5 ? sin((t-0.5)*TWO_PI*4)*10 : 0;
  float size = 350 + pulse;
  
  fill(colorGold, a * 0.8); ellipse(cx - offset, cy - offset/2, size, size);
  fill(colorRedBatak, a * 0.8); ellipse(cx + offset, cy - offset/2, size, size);
  fill(colorGreen, a * 0.8); ellipse(cx, cy + offset, size, size);
  
  blendMode(BLEND); 
  
  // Teks "MEDAN" Scale up & Glow
  if (t > 0.5) {
    float textProg = constrain(map(t, 0.5, 0.8, 0, 1), 0, 1);
    
    // Glow
    fill(255, 255, 255, a * textProg * 0.8);
    ellipse(cx, cy, 300 * textProg, 150 * textProg);
    
    fill(colorText, a * textProg);
    textAlign(CENTER, CENTER);
    textFont(fontTitle);
    
    // Efek Scale Up
    pushMatrix();
    translate(cx, cy);
    scale(textProg * 2.0); // Membesar hingga 2x
    text("MEDAN", 0, 0);
    popMatrix();
  }
}
