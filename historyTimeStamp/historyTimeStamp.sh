#!/bin/bash
# @author : Olcay Alkan
# MIT License
#
# Copyright (c) 2024 Olcay Alkan
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# /home/ ve /root/ dizinlerinde .bash_history veya .zsh_history dosyalarını bul
# Bulunan her dosya için işlem yapılır
for file in $(sudo find /home/ /root/ -type f \( -name '.bash_history' -o -name '.zsh_history' \)); do
    # user'ları al
    user=$(basename $(dirname "$file"))
    
    # User'ın shell türünü al
    shell_type=$(basename "$file")
    
    # User ve shell türünü yazdır
    echo "History for user: $user ($shell_type)"
    
    # Dosya okunabilir mi?
    if [[ -r "$file" ]]; then
        # history zsh türündeyse
        if [[ "$shell_type" == ".zsh_history" ]]; then
            # Zsh history dosyalarını işle
            sudo cat "$file" | sed -En "s/^: ([0-9]+):[0-9]+;/\1 /p" | while read timestamp cmd; do
                # Zaman damgasını tarih formatına çevir
                formatted_date=$(date -d @$timestamp "+%Y-%m-%d %H:%M:%S" 2>/dev/null || date -r $timestamp "+%Y-%m-%d %H:%M:%S")
                # Tarih ve user bilgisiyle birlikte komutu yazdır
                echo "$formatted_date $user $cmd"
            done
        # history bash türündeyse
        else
            # Bash history dosyalarını işle
            sudo cat "$file" | while read cmd; do
                # Komutu ve user bilgisini yazdır
                echo "$(date "+%Y-%m-%d %H:%M:%S") $user $cmd"
            done
        fi
    # Dosya okunamazsa hata mesajı ver
    else
        # Hata mesajı
        echo "Cannot read history file for user: $user ($shell_type)"
    fi
    # Dosya işlemi bittiğinde bir boşluk bırak.
    echo ""
done
