class Toby_MenuSoundBindingsContainer
{
    Array<Dictionary> menuSoundBindings;

    ui void Init()
    {
        Array<String> splitTokens;
        int lump = -1;
		while ((lump = Toby_WadsUtils.FindLump('Toby_MenuSoundBindings', lump + 1)) != -1)
		{
            Toby_Logger.Message("Lump ["..lump.."] has full name '"..Wads.GetLumpFullName(lump).."'", "Toby_Developer");
            string lumpContent = Wads.ReadLump(lump);
            splitTokens.Clear();
            lumpContent.Split(splitTokens, "\n", TOK_SKIPEMPTY);

            for (int i = 0; i < splitTokens.Size(); i++)
            {
                //Failsafe
                //{"a":"b"}
                //9 chars long, can't be smaller
                if (splitTokens[i].Length() < 9) { continue; }

                //Dumb check for commented line
                if (splitTokens[i].IndexOf("//") == 0) { continue; }

                //Replace sounds if exactly the same condition definition already exists:
                Dictionary soundBinding = Dictionary.FromString(splitTokens[i]);
                bool sameConditionFound = false;
                for (int j = 0; j < menuSoundBindings.Size(); j++)
                {
                    DictionaryIterator di = DictionaryIterator.Create(menuSoundBindings[j]);
                    bool sameCondition = true;
                    while (di.Next())
                    {
                        if (di.Key() == "SoundToPlay") { continue; }
                        if (soundBinding.At(di.Key()) == "")
                        {
                            sameCondition = false;
                            break;
                        }
                        if (soundBinding.At(di.Key()) != di.Value())
                        {
                            sameCondition = false;
                            break;
                        }
                    }
                    if (sameCondition)
                    {
                        menuSoundBindings[j] = soundBinding;
                        sameConditionFound = true;
                        break;
                    }
                }
                if (!sameConditionFound)
                {
                    menuSoundBindings.push(soundBinding);
                }
            }
            Toby_Logger.Message("Menu sound bindings added: "..menuSoundBindings.Size(), "Toby_Developer");
        }
    }
}
