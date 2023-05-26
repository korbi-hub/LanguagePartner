
function getVocab(hash)
{
    const jsonObject = Object.fromEntries(hash);
    return JSON.stringify(jsonObject);                         
}


// Weitergabe an den End user