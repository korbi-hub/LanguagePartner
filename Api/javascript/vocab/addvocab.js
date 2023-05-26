
// Bekommen einen String mit den neuen Vokabeln die wir in der Datenbank speichern wollen


function getHash(str)
{
    const hash = new Map();
    obj = JSON.parse(str);
    for(const key in obj)
    {
        hash.set(key, obj[key]);
    }
    return hash
}


// Weitergabe in die Datenbank