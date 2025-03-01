class NumberToVoice ui
{
    ui static void AddStringNumberToQueue(string numberAsString)
    {
        int dotPlace = numberAsString.IndexOf(".", 0);
        string firstPart = numberAsString.Mid(0, dotPlace);
        string secondPart = numberAsString.Mid(dotPlace + 1, numberAsString.Length() - 1);
        secondPart.StripRight("0");
        bool skipZeroAfterDot = true;
        if (secondPart.Length() == 0)
        {
            secondPart = "0";
        }
        if (secondPart == "0" && skipZeroAfterDot == false)
        {
            UnshiftSingleDigitToQueue(secondPart.Mid(0, 1));
            SoundQueue.UnshiftSound("numbers/dot", -1);
        }
        else if (secondPart != "0")
        {
            for (int i = secondPart.Length() - 1; i >= 0; i--)
            {
                UnshiftSingleDigitToQueue(secondPart.Mid(i, 1));
            }
            SoundQueue.UnshiftSound("numbers/dot", -1);
        }
        ConvertAndAddToQueue(firstPart.ToInt());
    }

    ui static void ConvertFloatAndAddToQueue(float number)
    {
        string numberAsString = ""..number;
        AddStringNumberToQueue(numberAsString);
    }

    ui static void ConvertAndAddToQueue(int number)
    {
        int power = 0;
        bool hasMinus = false;
        string numberAsString = ""..number;
        if (numberAsString.Mid(1,1) == "-")
        {
            numberAsString = numberAsString.Mid(1, numberAsString.Length() - 1);
            hasMinus = true;
        }
        string numberSegment;
        bool lastDigits = false;
        do
        {
            if (numberAsString.Length() != 0)
            {
                UnshiftPowers(power);
            }
            if (numberAsString.Length() >= 3)
            {
                numberSegment = ""..numberAsString.Mid(numberAsString.Length() - 3, 3);
                numberAsString = ""..numberAsString.Mid(0, numberAsString.Length() - 3);
                power++;
            }
            else
            {
                lastDigits = true;
                numberSegment = numberAsString;
                if (numberSegment.Length() < 2)
                {
                    numberSegment = "00"..numberSegment;
                }
                if (numberSegment.Length() < 3)
                {
                    numberSegment = "0"..numberSegment;
                }
                if (numberSegment == "000" && power == 0)
                {
                    SoundQueue.UnshiftSound("numbers/000", -1);
                    return;
                }
            }
            UnshiftTripleDigits(numberSegment, lastDigits);
        } while (lastDigits == false);
        if (hasMinus)
        {
            SoundQueue.UnshiftSound("numbers/minus", -1);
        }
    }

    ui static void UnshiftPowers(int digit)
    {
        if (digit == 1) SoundQueue.UnshiftSound("numbers/thousand", -1);
        if (digit == 2) SoundQueue.UnshiftSound("numbers/million", -1);
        if (digit == 3) SoundQueue.UnshiftSound("numbers/billion", -1);
        if (digit == 4) SoundQueue.UnshiftSound("numbers/trillion", -1);
    }

    ui static void UnshiftSingleDigitToQueue(string digit)
    {
        SoundQueue.UnshiftSound(GetSingleDigitSoundName(digit), -1);
    }

    ui static void AddSingleDigitToQueue(string digit)
    {
        SoundQueue.AddSound(GetSingleDigitSoundName(digit), -1);
    }

    ui static void UnshiftDoubleDigits(string doubleDigits)
    {
        if (doubleDigits == "10") SoundQueue.UnshiftSound("numbers/010", -1);
        if (doubleDigits == "11") SoundQueue.UnshiftSound("numbers/011", -1);
        if (doubleDigits == "12") SoundQueue.UnshiftSound("numbers/012", -1);
        if (doubleDigits == "13") SoundQueue.UnshiftSound("numbers/013", -1);
        if (doubleDigits == "14") SoundQueue.UnshiftSound("numbers/014", -1);
        if (doubleDigits == "15") SoundQueue.UnshiftSound("numbers/015", -1);
        if (doubleDigits == "16") SoundQueue.UnshiftSound("numbers/016", -1);
        if (doubleDigits == "17") SoundQueue.UnshiftSound("numbers/017", -1);
        if (doubleDigits == "18") SoundQueue.UnshiftSound("numbers/018", -1);
        if (doubleDigits == "19") SoundQueue.UnshiftSound("numbers/019", -1);
        if (doubleDigits == "20") SoundQueue.UnshiftSound("numbers/020", -1);
        if (doubleDigits == "30") SoundQueue.UnshiftSound("numbers/030", -1);
        if (doubleDigits == "40") SoundQueue.UnshiftSound("numbers/040", -1);
        if (doubleDigits == "50") SoundQueue.UnshiftSound("numbers/050", -1);
        if (doubleDigits == "60") SoundQueue.UnshiftSound("numbers/060", -1);
        if (doubleDigits == "70") SoundQueue.UnshiftSound("numbers/070", -1);
        if (doubleDigits == "80") SoundQueue.UnshiftSound("numbers/080", -1);
        if (doubleDigits == "90") SoundQueue.UnshiftSound("numbers/090", -1);
        if (doubleDigits.Mid(1, 1) != "0" && doubleDigits.Mid(0, 1) != "1")
        {
            UnshiftSingleDigitToQueue(doubleDigits.Mid(1, 1));
            if (doubleDigits.Mid(0, 1) != "0")
            {
                if (doubleDigits.Mid(0, 1) == "2") SoundQueue.UnshiftSound("numbers/020", -1);
                if (doubleDigits.Mid(0, 1) == "3") SoundQueue.UnshiftSound("numbers/030", -1);
                if (doubleDigits.Mid(0, 1) == "4") SoundQueue.UnshiftSound("numbers/040", -1);
                if (doubleDigits.Mid(0, 1) == "5") SoundQueue.UnshiftSound("numbers/050", -1);
                if (doubleDigits.Mid(0, 1) == "6") SoundQueue.UnshiftSound("numbers/060", -1);
                if (doubleDigits.Mid(0, 1) == "7") SoundQueue.UnshiftSound("numbers/070", -1);
                if (doubleDigits.Mid(0, 1) == "8") SoundQueue.UnshiftSound("numbers/080", -1);
                if (doubleDigits.Mid(0, 1) == "9") SoundQueue.UnshiftSound("numbers/090", -1);
            }
        }
    }

    ui static void UnshiftTripleDigits(string tripleDigits, bool lastDigits)
    {
        string doubleDigits = ""..tripleDigits.Mid(1, 1)..tripleDigits.Mid(2, 1);
        if (doubleDigits != "00")
        {
            UnshiftDoubleDigits(doubleDigits);
            if (!lastDigits)
            {
                SoundQueue.UnshiftSound("numbers/and", -1);
            }
        }
        if (tripleDigits.Mid(0, 1) != "0")
        {
            SoundQueue.UnshiftSound("numbers/100", -1);
            UnshiftSingleDigitToQueue(tripleDigits.Mid(0, 1));
        }
    }

    ui static string GetSingleDigitSoundName(string digit)
    {
        string singleDigitSoundName = "alphabet/Space";
        if (digit == "0") singleDigitSoundName = "numbers/000";
        if (digit == "1") singleDigitSoundName = "numbers/001";
        if (digit == "2") singleDigitSoundName = "numbers/002";
        if (digit == "3") singleDigitSoundName = "numbers/003";
        if (digit == "4") singleDigitSoundName = "numbers/004";
        if (digit == "5") singleDigitSoundName = "numbers/005";
        if (digit == "6") singleDigitSoundName = "numbers/006";
        if (digit == "7") singleDigitSoundName = "numbers/007";
        if (digit == "8") singleDigitSoundName = "numbers/008";
        if (digit == "9") singleDigitSoundName = "numbers/009";
        return singleDigitSoundName;
    }
}
