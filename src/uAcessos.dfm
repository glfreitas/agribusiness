object FormAcessos: TFormAcessos
  Left = 402
  Top = 144
  Caption = '.:: Acessos'
  ClientHeight = 481
  ClientWidth = 850
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Courier New'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poOwnerFormCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 289
    Top = 40
    Height = 441
    ExplicitLeft = 209
    ExplicitHeight = 499
  end
  object PUsuario: TPanel
    Left = 0
    Top = 0
    Width = 850
    Height = 40
    Align = alTop
    BevelInner = bvLowered
    BevelWidth = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 292
    Top = 40
    Width = 558
    Height = 441
    ActivePage = TabAcessos
    Align = alClient
    TabOrder = 1
    object TabAcessos: TTabSheet
      Caption = 'Acessos'
      object TreeViewAcessos: TTreeView
        Left = 0
        Top = 0
        Width = 550
        Height = 410
        Align = alClient
        Images = ImageListAcessos
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnDblClick = TreeViewAcessosDblClick
      end
    end
  end
  object PageControl2: TPageControl
    Left = 0
    Top = 40
    Width = 289
    Height = 441
    ActivePage = TabUsuarios
    Align = alLeft
    TabOrder = 2
    object TabPerfis: TTabSheet
      Caption = 'Perfis'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object TreeViewPerfis: TTreeView
        Left = 0
        Top = 0
        Width = 309
        Height = 410
        Align = alLeft
        Images = ImageListAcessos
        Indent = 19
        ReadOnly = True
        TabOrder = 0
      end
    end
    object TabUsuarios: TTabSheet
      Caption = 'Usu'#225'rios'
      ImageIndex = 1
      object TreeViewUsuarios: TTreeView
        Left = 0
        Top = 0
        Width = 309
        Height = 410
        Align = alLeft
        Images = ImageListAcessos
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnDblClick = TreeViewUsuariosDblClick
      end
    end
  end
  object ImageListAcessos: TImageList
    Left = 24
    Top = 249
    Bitmap = {
      494C010106008800B00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C9C6C7009998
      9800868585006C6C6D005D5D5E007474740073737300757575007B7B7B008584
      850098979700C3C0C100E2DEDF00000000000000000000000000840000009C65
      0000FE030300C6C3C600C6C3C60000040000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A3A4006E6E6E009B9B
      9B00A0A0A20078756D00736C5F00999A9C00A6A6A600A3A3A300A2A2A200A0A0
      A0009C9C9C0070707000A5A3A40000000000000000000000000003060300C4C1
      C400FBFBFB00080B0800080B0800070A07000206020000820000008200000082
      0000008200000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073727200AEAEAE00ABAB
      AB009C9D9F00908A7800D3C8A600706E6D00A9AAAB00A8A8A800A8A8A800A8A8
      A800A9A9A900AFAFAF0074737300000000000000000004080400080B0800C4C1
      C400FBFBFB00EBE8EB00C4C1C400C4C1C400C4C1C4000206020000FF00000004
      0000639A63000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000088878700B1B1B100B3B3
      B30083838600B4AD9900FFFACD00918A770082838700B3B3B300AFAFAF00AFAF
      AF00B0B0B000B1B1B1008F8E8E000000000000040000C4C1C400C4C1C400080B
      0800FBFBFB00FBFBFB00EBE8EB00EBE8EB00E4E0E400080B0800848684000004
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0BDBE0093939300C0C0
      C10083838600C2BBA300FFFFD800F0EAC20088807400B4B3B400B8B8B900B8B8
      B800BDBDBD0084848400CCCACA000000000001050100E4E0E400E4E0E400C4C1
      C400080B0800FBFBFB00FBFBFB00FBFBFB00EBE8EB00E4E0E400080B08000206
      0200000400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E2DEDF00B1AFB000A0A0
      A0008A898900D0C9AB00EFF2CF00C0D8C60094ACA20072767500CAC5C200C2C2
      C2009D9D9D00BBB8B900000000000000000003060300EBE8EB00E4E0E400C4C1
      C400C4C1C400080B0800FBFBFB00FBFBFB00EBE8EB00E4E0E400080B08008587
      8500848684000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E2DEDF00C1BD
      BD00878380006C949E003691CF001E87DF00228BE100237BBA007798A800AFA9
      A700CAC7C80000000000000000000000000005080500FBFBFB00F3EFF300EBE8
      EB00E4E0E400080B0800FBFBFB00FBFBFB00080B0800080B0800A5A2A500A5A2
      A500A5A2A5000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A7BECA001E88DB00359FFF003BA2FF003BA2FF0036A2FF002088D400B7BF
      C5000000000000000000000000000000000003070300FBFBFB00FBFBFB00F3EF
      F300EBE8EB00080B0800FBFBFB00FBFBFB00EBE8EB00080B0800C4C1C400C5C2
      C500A5A2A500A5A2A50000040000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D8DB
      DF00499ED6003DA6FF0041A8FF0040A7FF0040A7FF0041A8FF003DACFF003C6F
      9200D0CBCB000000000000000000000000000000000002060200C4C1C400FBFB
      FB00EBE8EB00EBE8EB00080B0800FBFBFB00E4E0E400080B0800C4C1C400C5C2
      C500C6C3C600A5A2A50000040000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BACC
      D600339AE4004BB3FF0048B0FF0048AFFF0048AFFF004AB4FF004DB9FF00163B
      58008C888700000000000000000000000000000000000000000001050100C5C2
      C500FBFBFB00FBFBFB00F3EFF300C4C1C400C4C1C400C4C1C400080B0800C5C2
      C500000400000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B0C7
      D40039A5EA004AAEF70046AAF3004BB2FA004DB3FC0048A5E700285B7E000001
      0400615F5E000000000000000000000000000000000000000000000000000004
      00000206020005090500080B0800080B0800080B0800080B0800B4B1B400C6C3
      C600A5A2A5000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C4CF
      D7001B4259002F3F4A0031414C00263C49001C2F3C000F161A00020000000000
      0000838181000000000000000000000000000000000000000000000000000000
      0000000000000004000084868400B5B2B5005D605D005C5F5C0000040000C6C3
      C600A5A2A5000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D0CE
      CF00605A5700A49F9D0076716F004C4744002D28250019171500060505001616
      1600C7C4C4000000000000000000000000000000000000000000000000000000
      000000000000000000000004000084868400C6C3C600848684005A5D5A005A5D
      5A005A5D5A005A5D5A0000040000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ABA9A900696969007474740052525200313131001313130005050500ACA9
      AA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000400000004000000040000000400000004
      0000000400000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2DEDF00A4A2A20055545400323333002B2A2A0053525300AFACAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BBC9B90079A3
      7700478B4500297228001865190014791400167916001F7B1F002F822E00488D
      480077A47600B8C8B600E1DEDE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C8C6F009C8C6F0000000000000000000000000000000000000000009C8C
      6F009C8C6F009C8C6F00000000000000000000000000000000009C8C6F009C8C
      6F00000000000000000000000000000000000000000000000000000000000000
      00009C8C6F009C8C6F009C8C6F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084B583000376050006A1
      0D0001A50900187B12002C751D0007A4100012B01A0011AE18000FAC17000DAA
      14000AA51200037B06007DB17C00000000000000000000000000000000000000
      00000000000000000000000000009C8C6F009C8C6F0000000000000000000000
      0000000000009C8C6F009C8C6F000000000000000000000000009C8C6F000000
      0000000000009C8C6F009C8C6F0000000000000000009C8C6F00000000000000
      00009C8C6F000000000000000000000000000000000000000000000000009C8C
      6F0000000000000000009C8C6F009C8C6F000000000000000000000000000000
      000000000000000000000000000000000000000000001C7E1F001FBF2F0020BC
      30000FAF210049933A00C5CA99000C8010001EBE320022BB320022BB320022BB
      320022BC320022C334001B831F00000000000000000000000000000000000000
      0000000000000000000000000000000000009C8C6F0000000000000000000000
      00000000000000000000000000009C8C6F000000000000000000000000009999
      FF0000009900000000009C8C6F009C8C6F009C8C6F0000000000000099000000
      9900000000009C8C6F0000000000000000000000000000000000000000000000
      00000C4D24000C4D2400000000009C8C6F009C8C6F0000000000000000000000
      00000000000000000000000000000000000000000000449549002FCD490034CF
      4E000EA11F0085B46D00FFF8D900549341000CA31E0034D04E0032CB4A0032CB
      4A0033CD4C002DCD48004F9E5300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000009999
      FF000000FF0000009900000000009C8C6F00000000002600C4000000FF000000
      9900000000009C8C6F00000000000000000000000000000000009C8C6F000000
      000019A64D0019A64D000C4D2400000000009C8C6F009C8C6F00000000000000
      00000000000000000000000000000000000000000000AFCCAE001CB835004AEB
      710017AA2E00A0C08200FFFFE000EAEABE0030952B0039D95A0044DE650043DC
      640043E367001EA73000C0D2BD000000000000000000000000009C8C6F000000
      00000000000000000000000000008080800000000000000000009C8C6F009C8C
      6F009C8C6F000000000000000000000000000000000000000000000000000000
      00009999FF000000FF0000009900000000002600C4000000FF002600C4000000
      00009C8C6F0000000000000000000000000000000000000000000000000019A6
      4D0019A64D0000C0920019A64D000C4D2400000000009C8C6F009C8C6F000000
      00000000000000000000000000000000000000000000E2DFDF0096C59A002FD9
      570020B83D00B5CC8C00F5F1D400C5D7CB0082AD8E0019962D0056F67B0051F1
      7D003ABE5400A5C2A30000000000000000009C8C6F000000000000000000D1A7
      8F00D1A78F0000000000D1A78F00BD845900BD845900A4630000000000000000
      00009C8C6F009C8C6F00000000009C8C6F000000000000000000000000000000
      0000000000009999FF000000FF002600C4000000FF002600C400000000009C8C
      6F0000000000000000000000000000000000000000009C8C6F000000000019A6
      4D0000C092000000000000C0920019A64D000C4D2400000000009C8C6F009C8C
      6F00000000000000000000000000000000000000000000000000E2DFDF00ADC8
      AB004D9D5000539784003A90D4001E87DF00268AE400197CB10034B37E0073BF
      7900BFCDBC0000000000000000000000000000000000BD845900F0CD8E00F9EE
      D900F0CD8E00D1A78F0000000000BD845900BD845900A4630000A4630000BD84
      5900000000009C8C6F009C8C6F00000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF00000000009C8C6F009C8C
      6F0000000000000000000000000000000000000000000000000019A64D0000C0
      920000000000000000000000000000C0920019A64D000C4D2400000000009C8C
      6F009C8C6F000000000000000000000000000000000000000000000000000000
      0000A5C1C7001D88DB00359FFF003BA2FF003BA2FF003AA1FF002385D300B0C1
      BE000000000000000000000000000000000000000000BD845900F0CD8E000000
      0000F0CD8E00D1A78F00D1A78F000000000000000000A4630000A4630000BD84
      5900000000000000000000000000000000000000000000000000000000000000
      0000000000002600C4000000FF009999FF000000FF0000009900000000009C8C
      6F009C8C6F00000000000000000000000000000000000000000019A64D0019A6
      4D000000000000000000000000000000000000C0920019A64D000C4D24000000
      00009C8C6F009C8C6F000000000000000000000000000000000000000000D8DB
      DF004B9DD7003DA6FF0041A8FF0040A7FF0040A7FF0041A8FF003DACFF003E6E
      9600D0CBCB0000000000000000000000000000000000BD845900F0CD8E000000
      0000F0CD8E00D1A78F00D1A78F00BD845900BD845900A4630000A4630000BD84
      5900000000000000000000000000000000000000000000000000000000000000
      00002600C4000000FF002600C400000000009999FF000000FF00000099000000
      00009C8C6F009C8C6F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000C0920019A64D000C4D
      2400000000009C8C6F009C8C6F0000000000000000000000000000000000BACC
      D600339AE4004BB3FF0048B0FF0048AFFF0048AFFF004AB4FF004DB9FF00163B
      58008C88860000000000000000000000000000000000BD845900F0CD8E000000
      0000F0CD8E00D1A78F00D1A78F00BD845900BD845900A4630000A4630000BD84
      5900000000000000000000000000000000000000000000000000000000009999
      FF000000FF002600C4000000000000000000000000009999FF000000FF000000
      9900000000009C8C6F0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000C0920019A6
      4D000C4D2400000000009C8C6F0000000000000000000000000000000000B0C7
      D40039A5EA004AAEF70046AAF3004BB2FA004DB3FC0048A5E700285B7E000001
      0400615F5E0000000000000000000000000000000000BD845900BD845900BD84
      5900D1A78F00BD845900BD845900000000000000000066666600A4630000BD84
      5900000000000000000000000000000000000000000000000000000000009999
      FF009999FF0000000000000000000000000000000000000000009999FF009999
      FF00000000009C8C6F0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000C0
      920019A64D000C4D24000000000000000000000000000000000000000000C4CF
      D7001B4259002F3F4A0031414C00263C49001C2F3C000F161A00020000000000
      00008381810000000000000000000000000000000000A4630000A4630000F9EE
      D9000000000000000000F9EED900F9EED900F0CD8E00F0CD8E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C8C6F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000C0920019A64D000000000000000000000000000000000000000000D0CE
      CF00605A5700A49F9D0076716F004C4744002D28250019171500060505001616
      1600C7C4C40000000000000000000000000000000000F0CD8E00F9EED900F9EE
      D900F9EED900F9EED900F9EED900F9EED900F9EED900F9EED900F9EED900F0CD
      8E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ABA9A900696969007474740052525200313131001313130005050500ACA9
      AA00000000000000000000000000000000009C8C6F000000000000000000F0CD
      8E00F0CD8E00F9EED900F9EED900F9EED900F0CD8E00F0CD8E00000000000000
      00009C8C6F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E2DEDF00A4A2A20055545400323333002B2A2A0053525300AFACAD000000
      00000000000000000000000000000000000000000000000000009C8C6F006666
      66000000000000000000000000000000000000000000666666009C8C6F000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFF807F00000000C001C07F00000000
      8001C0070000000080018007000000008001000F000000008001000700000000
      8003000300000000C007000300000000F00F000100000000E007800100000000
      E007C00300000000E007E00300000000E007F80300000000E007FC0100000000
      F00FFE0300000000F01FFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFFC001FFC3
      E3CFF1FF8001F831C187E0FF8001F636C003E07F8001F606C003C03F8001C002
      E007C01F80030000F00F800FC0070001F80F8007F00F1007F0078603E0071007
      E003CF01E0071007C103FF81E0070007C383FFC1E0070C07E7C7FFE1E0070007
      FFFFFFF3F00F0007FFFFFFFFF01FC01F00000000000000000000000000000000
      000000000000}
  end
  object QPerfis: TADOQuery
    Connection = DM.Conexao
    Parameters = <>
    Left = 24
    Top = 88
  end
  object QUsuarios: TADOQuery
    Connection = DM.Conexao
    Parameters = <>
    Left = 24
    Top = 144
  end
  object QSQL: TADOQuery
    Connection = DM.Conexao
    Parameters = <>
    Left = 24
    Top = 200
  end
end