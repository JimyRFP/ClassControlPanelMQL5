//+------------------------------------------------------------------+
//|                                            ClassControlPanel.mqh |
//|                                            Rafael Floriani Pinto |
//|                           https://www.mql5.com/pt/users/rafaelfp |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""
#ifndef ClassControlPainelV1
#define ClassControlPainelV1
#define OBJMARGIMX 0.20
#define OBJMARGIMY 0.06
#define OBJGERALNAME "GERAL"
#define CHARTPRIORITYBASE 98
#define CHARTPRIORITYBUTTON 100
#define CHARTPRIORITYEDIT   100
#define CHARTPRIORITYTEXT   99
#define PANELBASELEVEL 99
enum ENUM_PANEL_INTEGER
  {
   PANEL_BGCOLOR,
   PANEL_BORDERCOLOR,
   PANEL_BORDERTYPE,
   PANEL_CORNERPOSITION
  };

enum ENUM_BUTTON_INTEGER
  {
   BUTTON_STATE,
   BUTTON_BGCOLOR,
   BUTTON_BORDERCOLOR,
   BUTTON_BORDERTYPE,
   BUTTON_FONTSIZE,
   BUTTON_FONTCOLOR
  };
enum ENUM_BUTTON_STRING
  {
   BUTTON_TEXTSHOW
  };
enum ENUM_TEXT_INTEGER
  {
   TEXT_FONTSIZE,
   TEXT_FONTCOLOR,
   TEXT_READONLY
  };
enum ENUM_TEXT_STRING
  {
   TEXT_TEXTSHOW
  };
enum ENUM_BUTTONEDIT_INTEGER{
BUTTONEDIT_BGCOLOR,
BUTTONEDIT_BORDERCOLOR,
BUTTONEDIT_FONTCOLOR,
BUTTONEDIT_STATE,
BUTTONEDIT_READONLY

};
enum ENUM_BUTTONEDIT_STRING{
BUTTONEDIT_TEXTSHOW

};
enum ENUM_EDITEDIT_INTEGER{
EDITEDIT_READONLY,
EDITEDIT_BORDERCOLOR

};
enum ENUM_EDITEDIT_STRING{
EDITEDIT_TEXTSHOW
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CControlPainel
  {
public:
                     CControlPainel(long=0,double=0.25,double=0.25,long=5,long=5,ENUM_BASE_CORNER=CORNER_LEFT_LOWER,string="PanelControl");
   bool              CreatePanel();
   void              DeletePanel();
   bool              CreateButton(const string,color,color,color,ENUM_BORDER_TYPE);
   bool              CreateText(const string,color,int,bool=true);
   bool              CreateButtonEdit(const string,double,color,color,color,ENUM_BORDER_TYPE,int);
   bool              CreateEditEdit(const string,double,color,int);
   long              ButtonGetInteger(int,ENUM_BUTTON_INTEGER);
   string            TextGetString(int);
   void              PanelModifyInteger(ENUM_PANEL_INTEGER,long);
   void              ButtonSetInteger(int,ENUM_BUTTON_INTEGER,long);
   void              ButtonSetString(int,ENUM_BUTTON_STRING,const string);
   void              TextSetInteger(int,ENUM_TEXT_INTEGER,long);
   void              TextSetString(int,ENUM_TEXT_STRING,const string);
   void              PanelSetFont(const string);
   bool              RefreshPanel();
   ulong             ButtonEditGetInteger(int,ENUM_BUTTONEDIT_INTEGER);
   void              ButtonEditSetInteger(int,bool,ENUM_BUTTONEDIT_INTEGER,ulong);
   void              ButtonEditSetString(int,bool,ENUM_BUTTONEDIT_STRING,const string);
   string            ButtonEditGetString(int,ENUM_BUTTONEDIT_STRING);
   void              EditEditSetString(int,bool,ENUM_EDITEDIT_STRING,const string);
   void              EditEditSetInteger(int,bool,ENUM_EDITEDIT_INTEGER,const ulong);
   string            EditEditGetString(int,ENUM_EDITEDIT_STRING);
   void              SetPanelOnTop();
   void              SetWidthProp(const double);
   void              SetHeightProp(const double);
   bool              ButtonGetState(int);
   void              ButtonSetState(int N,bool state);
private:
   //CONSTS
   const long        ID;
   //VARS
   double            PropWidth;
   double            PropHeight;
   int               ChartWidth;
   int               ChartHeight;
   long              XMargim;
   long              YMargim;
   string            FontName;
   //PANEL STATUS
   string            PanelName;
   long              PanelWidth;
   long              PanelHeight;
   ENUM_BASE_CORNER  PanelCorner;
   color             PanelBGColor;
   color             PanelBorderColor;
   ENUM_BORDER_TYPE  PanelBorder;
   //OBJ DIMENSIONS
   int               NumbersObjects;
   int               NumberButtons[];
   int               NumberTexts[];
   int               NumberButtonEdit[];
   int               NumberEditEdit[];
   double            ButtonEditProp[];
   double            EditEditProp[];
   long              ObjXSize;
   long              ObjYSize;
   long              ObjXMargim;
   long              ObjYMargim;
   long              ObjAddYMargim;
   //FUNCS
   long              SetXDistance(ENUM_BASE_CORNER,long,long);
   long              SetYDistance(ENUM_BASE_CORNER,long,long);
   bool              ChangePanelAppearence();
   void              SetObjectYDimensions();
   void              SetObjectXDimensions();
   long              SetYMargimObj(int);
   void              SetObjectsPlace();
   string            GetGeralName(const string,int)const;
   bool              PanelNameCompare(const string,const string)const;
   
  };




//+------------------------------------------------------------------+
//|CONSTRUCTOR                                                       |
//+------------------------------------------------------------------+
CControlPainel::CControlPainel(long Chart_ID=0,double PropWidthGraf=0.250000,double PropHeightGraf=0.250000,
                               long XMARGIM=5,long YMARGIM=5,ENUM_BASE_CORNER ObjCorner=CORNER_LEFT_LOWER,string PANELNAME="PanelControl")
   :ID(Chart_ID),
    PropWidth(PropWidthGraf>0 && PropWidthGraf<1  ? PropWidthGraf :0.25),
    PropHeight(PropHeightGraf>0 && PropHeightGraf<1? PropHeightGraf :0.25),
    PanelCorner(ObjCorner),
    PanelName(PANELNAME),
    ChartWidth((int)ChartGetInteger(ID,CHART_WIDTH_IN_PIXELS,0)),
    ChartHeight((int)ChartGetInteger(ID,CHART_HEIGHT_IN_PIXELS,0)),
    XMargim(XMARGIM>0?XMARGIM:5),
    YMargim(YMARGIM>0?YMARGIM:5),
    PanelBGColor(clrBlack),
    PanelBorderColor(clrWhite),
    PanelBorder(BORDER_RAISED),
    NumbersObjects(0),
    FontName("Times New Roman")
  {

  }
//+------------------------------------------------------------------+
//|PUBLIC DEFINITIONS                                                |
//+------------------------------------------------------------------+
bool CControlPainel::CreatePanel()
  {


   if(!ObjectCreate(ID,PanelName,OBJ_RECTANGLE_LABEL,0,0,0))
     {
      return false;
     }
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_CORNER,PanelCorner))
     {
      return false;
     }
   PanelWidth=(long)(PropWidth*ChartWidth);
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_XSIZE,PanelWidth))
     {
      return false;
     }
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_XDISTANCE,SetXDistance(PanelCorner,XMargim,PanelWidth)))
     {
      return false;
     }
   PanelHeight=(long)(PropHeight*ChartHeight);
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_YSIZE,PanelHeight))
     {
      return false;
     }
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_YDISTANCE,SetYDistance(PanelCorner,YMargim,PanelHeight)))
     {
      return false;
     }
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_ZORDER,CHARTPRIORITYBASE))
     {
      return false;
     }  
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_LEVELS,PANELBASELEVEL))
     {
      return false;
     }
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_BACK,false))
     {
      return false;
     }
   if(!ChangePanelAppearence())
      return false;

   return true;
  }
//---
void CControlPainel::SetWidthProp(const double WP){
if(WP<0 || WP>1)return;
PropWidth=WP;

return;
} 
void CControlPainel::SetHeightProp(const double HP){
if(HP<0 || HP>1)return;
PropHeight=HP;
return;
} 
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::DeletePanel(void)
  {
   ObjectDelete(ID,PanelName);
   for(int i=1; i<=NumbersObjects; i++)
     {
      ObjectDelete(ID,GetGeralName(OBJGERALNAME,i));
     }
     
   NumbersObjects=0;
   ArrayFree(NumberButtons);
   ArrayFree(NumberTexts);
   ArrayFree(NumberButtonEdit);
   ArrayFree(NumberEditEdit);
   ArrayFree(ButtonEditProp);
   ArrayFree(EditEditProp);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlPainel::CreateButton(const string BntText="Bnt",color FontColor=clrWhite,color BntBGColor=clrRed,
                                  color BntBorderColor=clrWhite,ENUM_BORDER_TYPE BntBorder=BORDER_RAISED)
  {
   NumbersObjects++;
   int N=ArraySize(NumberButtons);
   ArrayResize(NumberButtons,N+1);
   NumberButtons[N]=NumbersObjects;
   string BntName=GetGeralName(OBJGERALNAME,NumbersObjects);
   if(!ObjectCreate(ID,BntName,OBJ_BUTTON,0,0,0))
     {
      ArrayResize(NumberButtons,N);
      NumbersObjects--;
      return false;
     }
   SetObjectsPlace();
   if(!ObjectSetInteger(ID,BntName,OBJPROP_BGCOLOR,BntBGColor) || !ObjectSetInteger(ID,BntName,OBJPROP_BORDER_TYPE,BntBorder) ||
      !ObjectSetInteger(ID,BntName,OBJPROP_BORDER_COLOR,BntBorderColor)|| !ObjectSetInteger(ID,BntName,OBJPROP_COLOR,FontColor) ||
      !ObjectSetString(ID,BntName,OBJPROP_TEXT,BntText) || !ObjectSetInteger(ID,BntName,OBJPROP_READONLY,true)
      || !ObjectSetInteger(ID,BntName,OBJPROP_ZORDER,CHARTPRIORITYBUTTON))
     {
      
     }




   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlPainel::CreateText(const string TextT="Text",color FontColor=clrWhite,int TextFontSize=10,bool ReadOnly=true)
  {
   NumbersObjects++;
   int N=ArraySize(NumberTexts);
   ArrayResize(NumberTexts,N+1);
   NumberTexts[N]=NumbersObjects;
   string TextName=GetGeralName(OBJGERALNAME,NumbersObjects);
   if(!ObjectCreate(ID,TextName,OBJ_EDIT,0,0,0))
     {
      ArrayResize(NumberTexts,N);
      NumbersObjects--;
      return false;
      printf("erro");
     }
   SetObjectsPlace();
   if(!ObjectSetInteger(ID,TextName,OBJPROP_BGCOLOR,PanelBGColor) || !ObjectSetInteger(ID,TextName,OBJPROP_BORDER_TYPE,BORDER_FLAT) ||
      !ObjectSetInteger(ID,TextName,OBJPROP_BORDER_COLOR,PanelBGColor)|| !ObjectSetInteger(ID,TextName,OBJPROP_COLOR,FontColor) ||
      !ObjectSetString(ID,TextName,OBJPROP_TEXT,TextT) || !ObjectSetInteger(ID,TextName,OBJPROP_READONLY,ReadOnly)
      ||  !ObjectSetInteger(ID,TextName,OBJPROP_ALIGN,ALIGN_CENTER)  ||
      !ObjectSetInteger(ID,TextName,OBJPROP_ZORDER,CHARTPRIORITYTEXT) ||  !ObjectSetInteger(ID,TextName,OBJPROP_FONTSIZE,TextFontSize))
     {
     
     }





   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long CControlPainel::ButtonGetInteger(int WhatBnt,ENUM_BUTTON_INTEGER Type)
  {
   int N=ArraySize(NumberButtons);
   if(WhatBnt<=0 || WhatBnt>N)
      return 0;
   string Name=GetGeralName(OBJGERALNAME,NumberButtons[WhatBnt-1]);
   switch(Type){
   case BUTTON_STATE:{return (bool)ObjectGetInteger(ID,Name,OBJPROP_STATE);}
   
   default:return 0;   
   }
   
   
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CControlPainel::TextGetString(int WhatTxt)
  {
   int N=ArraySize(NumberTexts);
   if(WhatTxt<=0 || WhatTxt>N)
      return NULL;
   string Name=GetGeralName(OBJGERALNAME,NumberTexts[WhatTxt-1]);
   return ObjectGetString(ID,Name,OBJPROP_TEXT);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::PanelModifyInteger(ENUM_PANEL_INTEGER PropertId,long Val)
  {
   switch(PropertId)
     {
      case PANEL_BGCOLOR:
         if(ObjectSetInteger(ID,PanelName,OBJPROP_BGCOLOR,Val))
           {
            PanelBGColor=(color)Val;
            for(int i=1; i<=ArraySize(NumberTexts); i++)
              {
               ObjectSetInteger(ID,GetGeralName(OBJGERALNAME,NumberTexts[i-1]),OBJPROP_BGCOLOR,PanelBGColor);
               ObjectSetInteger(ID,GetGeralName(OBJGERALNAME,NumberTexts[i-1]),OBJPROP_BORDER_COLOR,PanelBGColor);
              }
           }
         return;
      case PANEL_BORDERCOLOR:
         if(ObjectSetInteger(ID,PanelName,OBJPROP_BORDER_COLOR,Val))
           {
            PanelBorderColor=(color)Val;
           }
         return;
      case PANEL_BORDERTYPE:
         if(ObjectSetInteger(ID,PanelName,OBJPROP_BORDER_TYPE,Val))
           {
            PanelBorder=(ENUM_BORDER_TYPE)Val;
           }
         return;
      case PANEL_CORNERPOSITION:
         if(ObjectSetInteger(ID,PanelName,OBJPROP_CORNER,Val))
           {
            PanelCorner=(ENUM_BASE_CORNER)Val;
            ObjectSetInteger(ID,PanelName,OBJPROP_XDISTANCE,SetXDistance(PanelCorner,XMargim,PanelWidth));
            ObjectSetInteger(ID,PanelName,OBJPROP_YDISTANCE,SetYDistance(PanelCorner,YMargim,PanelHeight));
            SetObjectsPlace();
           }
      default:
         return;
     };

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::ButtonSetInteger(int WhatBnt,ENUM_BUTTON_INTEGER PropertID,long Val)
  {
   int N=ArraySize(NumberButtons);
   if(WhatBnt<=0 || WhatBnt>N)
      return;
   string Name=GetGeralName(OBJGERALNAME,NumberButtons[WhatBnt-1]);
   switch(PropertID)
     {
      case BUTTON_BGCOLOR:
         ObjectSetInteger(ID,Name,OBJPROP_BGCOLOR,Val);
         return;
      case BUTTON_BORDERCOLOR:
         ObjectSetInteger(ID,Name,OBJPROP_BORDER_COLOR,Val);
         return;
      case BUTTON_BORDERTYPE:
         ObjectSetInteger(ID,Name,OBJPROP_BORDER_TYPE,Val);
         return;
      case BUTTON_FONTCOLOR:
         ObjectSetInteger(ID,Name,OBJPROP_COLOR,Val);
         return;
      case BUTTON_FONTSIZE:
         ObjectSetInteger(ID,Name,OBJPROP_FONTSIZE,Val);
         return;
      case BUTTON_STATE:
         ObjectSetInteger(ID,Name,OBJPROP_STATE,Val);
         return;   
         
      default:
         return;
     };

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::ButtonSetString(int WhatBnt,ENUM_BUTTON_STRING PropertID,const string Text)
  {
   int N=ArraySize(NumberButtons);
   if(WhatBnt<=0 || WhatBnt>N)
      return;
   string Name=GetGeralName(OBJGERALNAME,NumberButtons[WhatBnt-1]);
   switch(PropertID)
     {
      case BUTTON_TEXTSHOW:
         ObjectSetString(ID,Name,OBJPROP_TEXT,Text);
         return;
      default:
         return;
     };

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::TextSetInteger(int WhatTxt,ENUM_TEXT_INTEGER PropertID,long Val)
  {
   int N=ArraySize(NumberTexts);
   if(WhatTxt<=0 || WhatTxt>N)
      return;
   string Name=GetGeralName(OBJGERALNAME,NumberTexts[WhatTxt-1]);
   switch(PropertID)
     {
      case TEXT_FONTCOLOR:
         ObjectSetInteger(ID,Name,OBJPROP_COLOR,Val);
         return;
      case TEXT_FONTSIZE:
         ObjectSetInteger(ID,Name,OBJPROP_FONTSIZE,Val);
         return;
      case TEXT_READONLY:
         ObjectSetInteger(ID,Name,OBJPROP_READONLY,Val);
         return;
      default:
         return;
     };

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::TextSetString(int WhatTxt,ENUM_TEXT_STRING PropertID,const string Text)
  {
   int N=ArraySize(NumberTexts);
   if(WhatTxt<=0 || WhatTxt>N)
      return;
   string Name=GetGeralName(OBJGERALNAME,NumberTexts[WhatTxt-1]);
   switch(PropertID)
     {
      case TEXT_TEXTSHOW:
         ObjectSetString(ID,Name,OBJPROP_TEXT,Text);
         return;
      default:
         return;
     };

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::PanelSetFont(const string NameFont)
  {
   if(ObjectSetString(ID,PanelName,OBJPROP_FONT,NameFont))
     {
      FontName=NameFont;
      string Name;
      for(int i=1; i<=NumbersObjects; i++)
        {
         Name=GetGeralName(OBJGERALNAME,i);
         ObjectSetString(ID,Name,OBJPROP_FONT,FontName);

        }

     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlPainel::RefreshPanel(){
ChartWidth=(int)ChartGetInteger(ID,CHART_WIDTH_IN_PIXELS);
ChartHeight=(int)ChartGetInteger(ID,CHART_HEIGHT_IN_PIXELS);
PanelWidth=(long)(ChartWidth*PropWidth);
PanelHeight=(long)(ChartHeight*PropHeight);
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_XSIZE,PanelWidth))return false;
     
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_XDISTANCE,SetXDistance(PanelCorner,XMargim,PanelWidth)))return false;
     
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_YSIZE,PanelHeight))return false;
     
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_YDISTANCE,SetYDistance(PanelCorner,YMargim,PanelHeight)))return false;
     
   if(!ChangePanelAppearence())return false;
   
   SetObjectsPlace();


return true;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlPainel::CreateButtonEdit(const string BntText="BNT",double BntProp=0.6,color FontColor=clrWhite,color BntBGColor=clrRed,
                                  color BntBorderColor=clrWhite,ENUM_BORDER_TYPE BntBorder=BORDER_RAISED
                                  ,int TextFontSize=10                                  
                                  ){
   if(BntProp<0 || BntProp>1)return false;
   
   NumbersObjects+=2;
   int N=ArraySize(NumberButtonEdit);
   ArrayResize(NumberButtonEdit,N+1);
   ArrayResize(ButtonEditProp,N+1);
   NumberButtonEdit[N]=NumbersObjects-1;
   ButtonEditProp[N]=BntProp;
   
   string BntName=GetGeralName(OBJGERALNAME,NumbersObjects-1);
   if(!ObjectCreate(ID,BntName,OBJ_BUTTON,0,0,0))
     {
      ArrayResize(NumberButtonEdit,N);
      ArrayResize(ButtonEditProp,N);
      NumbersObjects-=2;printf("Erro");
      return false;
     }
     string TextName=GetGeralName(OBJGERALNAME,NumbersObjects);
   if(!ObjectCreate(ID,TextName,OBJ_EDIT,0,0,0))
     {
      ArrayResize(NumberButtonEdit,N);
      ArrayResize(ButtonEditProp,N);
      NumbersObjects-=2;printf("Erro");
      return false;
     }
     
   SetObjectsPlace();
   if(!ObjectSetInteger(ID,BntName,OBJPROP_BGCOLOR,BntBGColor) || !ObjectSetInteger(ID,BntName,OBJPROP_BORDER_TYPE,BntBorder) ||
      !ObjectSetInteger(ID,BntName,OBJPROP_BORDER_COLOR,BntBorderColor)|| !ObjectSetInteger(ID,BntName,OBJPROP_COLOR,FontColor) ||
      !ObjectSetString(ID,BntName,OBJPROP_TEXT,BntText) || !ObjectSetInteger(ID,BntName,OBJPROP_READONLY,true)
      || !ObjectSetInteger(ID,BntName,OBJPROP_ZORDER,CHARTPRIORITYBUTTON))
     {
      ArrayResize(NumberButtonEdit,N);
    ArrayResize(ButtonEditProp,N);
      NumbersObjects-=2;printf("Erro");
      SetObjectsPlace();
      return false;
     }
     
     if(!ObjectSetInteger(ID,TextName,OBJPROP_BGCOLOR,PanelBGColor) || !ObjectSetInteger(ID,TextName,OBJPROP_BORDER_TYPE,BORDER_FLAT) ||
      !ObjectSetInteger(ID,TextName,OBJPROP_BORDER_COLOR,clrWhite)|| !ObjectSetInteger(ID,TextName,OBJPROP_COLOR,clrWhite) ||
      !ObjectSetString(ID,TextName,OBJPROP_TEXT,"0") || !ObjectSetInteger(ID,TextName,OBJPROP_READONLY,false)
      ||  !ObjectSetInteger(ID,TextName,OBJPROP_ALIGN,ALIGN_CENTER)  ||  !ObjectSetInteger(ID,TextName,OBJPROP_FONTSIZE,TextFontSize)
      || !ObjectSetInteger(ID,TextName,OBJPROP_ZORDER,CHARTPRIORITYEDIT))
     {
      ArrayResize(NumberButtonEdit,N);
    ArrayResize(ButtonEditProp,N);
      NumbersObjects-=2;printf("Erro");
      SetObjectsPlace();
      return false;
     }

   
   

return true;

}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlPainel::CreateEditEdit(const string EditText,double EditProp=0.6,color FontColor=clrWhite,int TextFontSize=10){
if(EditProp<0 || EditProp>1)return false;
NumbersObjects+=2;
   int N=ArraySize(NumberEditEdit);
   ArrayResize(NumberEditEdit,N+1);
   ArrayResize(EditEditProp,N+1);
   NumberEditEdit[N]=NumbersObjects-1;
   EditEditProp[N]=EditProp;
   string TextName=GetGeralName(OBJGERALNAME,NumbersObjects-1);
   string TextName2=GetGeralName(OBJGERALNAME,NumbersObjects);
   if(!ObjectCreate(ID,TextName,OBJ_EDIT,0,0,0))
     {
      ArrayResize(NumberEditEdit,N);
      ArrayResize(EditEditProp,N);
      NumbersObjects-=2;printf("Erro");
      return false;
     }
    if(!ObjectCreate(ID,TextName2,OBJ_EDIT,0,0,0))
     {
      ArrayResize(NumberEditEdit,N);
      ArrayResize(EditEditProp,N);
      NumbersObjects-=2;printf("Erro");
      return false;
     }  
   SetObjectsPlace();
     
     if(!ObjectSetInteger(ID,TextName,OBJPROP_BGCOLOR,PanelBGColor) || !ObjectSetInteger(ID,TextName,OBJPROP_BORDER_TYPE,BORDER_FLAT) ||
      !ObjectSetInteger(ID,TextName,OBJPROP_BORDER_COLOR,PanelBGColor)|| !ObjectSetInteger(ID,TextName,OBJPROP_COLOR,FontColor) ||
      !ObjectSetString(ID,TextName,OBJPROP_TEXT,EditText) || !ObjectSetInteger(ID,TextName,OBJPROP_READONLY,true)
      ||  !ObjectSetInteger(ID,TextName,OBJPROP_ALIGN,ALIGN_CENTER)  ||  !ObjectSetInteger(ID,TextName,OBJPROP_FONTSIZE,TextFontSize)
      || !ObjectSetInteger(ID,TextName,OBJPROP_ZORDER,CHARTPRIORITYEDIT) )
     {
      ArrayResize(NumberEditEdit,N);
      ArrayResize(EditEditProp,N);
      NumbersObjects-=2;printf("Erro");
      return false;
     }
     
     if(!ObjectSetInteger(ID,TextName2,OBJPROP_BGCOLOR,PanelBGColor) || !ObjectSetInteger(ID,TextName2,OBJPROP_BORDER_TYPE,BORDER_FLAT) ||
      !ObjectSetInteger(ID,TextName2,OBJPROP_BORDER_COLOR,clrWhite)|| !ObjectSetInteger(ID,TextName2,OBJPROP_COLOR,FontColor) ||
      !ObjectSetString(ID,TextName2,OBJPROP_TEXT,"0") || !ObjectSetInteger(ID,TextName2,OBJPROP_READONLY,false)
      ||  !ObjectSetInteger(ID,TextName2,OBJPROP_ALIGN,ALIGN_CENTER)  ||  !ObjectSetInteger(ID,TextName2,OBJPROP_FONTSIZE,TextFontSize)
      || !ObjectSetInteger(ID,TextName2,OBJPROP_ZORDER,CHARTPRIORITYEDIT) )
     {
      ArrayResize(NumberEditEdit,N);
      ArrayResize(EditEditProp,N);
      NumbersObjects-=2;printf("Erro");
      return false;
     }
   
   
   
   
return true;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ulong CControlPainel::ButtonEditGetInteger(int N,ENUM_BUTTONEDIT_INTEGER Ope){
if(ArraySize(NumberButtonEdit)<N || N<1)return false;
string Name=GetGeralName(OBJGERALNAME,NumberButtonEdit[N-1]);
switch(Ope){
case BUTTONEDIT_STATE:return (bool)ObjectGetInteger(ID,Name,OBJPROP_STATE);
case BUTTONEDIT_BGCOLOR:return (color)ObjectGetInteger(ID,Name,OBJPROP_BGCOLOR);
case BUTTONEDIT_BORDERCOLOR:(color)ObjectGetInteger(ID,Name,OBJPROP_BORDER_COLOR);
case BUTTONEDIT_FONTCOLOR:(color)ObjectGetInteger(ID,Name,OBJPROP_COLOR);
default :return false;
};
return false;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::ButtonEditSetInteger(int N,bool First,ENUM_BUTTONEDIT_INTEGER Ope,ulong Val){
if(ArraySize(NumberButtonEdit)<N || N<1)return;
int K=NumberButtonEdit[N-1];
if(!First)K++;
string Name=GetGeralName(OBJGERALNAME,K);
switch(Ope){
case BUTTONEDIT_STATE:ObjectSetInteger(ID,Name,OBJPROP_STATE,(bool)Val);return;
case BUTTONEDIT_BGCOLOR:ObjectSetInteger(ID,Name,OBJPROP_BGCOLOR,(color)Val);return;
case BUTTONEDIT_BORDERCOLOR:ObjectSetInteger(ID,Name,OBJPROP_BORDER_COLOR,(color)Val);return;
case BUTTONEDIT_FONTCOLOR:ObjectSetInteger(ID,Name,OBJPROP_COLOR,(color)Val);return;
case BUTTONEDIT_READONLY:ObjectSetInteger(ID,Name,OBJPROP_READONLY,(bool)Val);return;
default :return;
};
return;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CControlPainel::ButtonEditGetString(int N,ENUM_BUTTONEDIT_STRING Ope){
if(ArraySize(NumberButtonEdit)<N || N<1)return "InvalidN";
string Name=GetGeralName(OBJGERALNAME,NumberButtonEdit[N-1]+1);
switch(Ope){
case BUTTONEDIT_TEXTSHOW:return ObjectGetString(ID,Name,OBJPROP_TEXT);

default: return "InvalidEnum";
}

}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::ButtonEditSetString(int N,bool first,ENUM_BUTTONEDIT_STRING Ope,const string Val){
if(ArraySize(NumberButtonEdit)<N || N<1)return;
int K;
if(first){K=NumberButtonEdit[N-1];}
else K=NumberButtonEdit[N-1]+1;
string Name=GetGeralName(OBJGERALNAME,K);
switch(Ope){
case BUTTONEDIT_TEXTSHOW:ObjectSetString(ID,Name,OBJPROP_TEXT,Val);return;

default: return;
}
return;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CControlPainel::EditEditGetString(int N,ENUM_EDITEDIT_STRING Ope){
if(ArraySize(NumberEditEdit)<N || N<1)return "Invalid N";
string Name=GetGeralName(OBJGERALNAME,NumberEditEdit[N-1]+1);
switch(Ope){
case EDITEDIT_TEXTSHOW:return ObjectGetString(ID,Name,OBJPROP_TEXT);

default: return "Invalid enum";
}
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::EditEditSetString(int N,bool First,ENUM_EDITEDIT_STRING Ope,const string Val){
if(ArraySize(NumberEditEdit)<N || N<1)return;
int K;
if(First){K=NumberEditEdit[N-1];}
else K=NumberEditEdit[N-1]+1;
string Name=GetGeralName(OBJGERALNAME,K);
switch(Ope){
case EDITEDIT_TEXTSHOW:ObjectSetString(ID,Name,OBJPROP_TEXT,Val);return;

default: return;
}
return;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::EditEditSetInteger(int N,bool First,ENUM_EDITEDIT_INTEGER Ope,const ulong Val){
if(ArraySize(NumberEditEdit)<N || N<1)return;
int K;
if(First){K=NumberEditEdit[N-1];}
else K=NumberEditEdit[N-1]+1;
string Name=GetGeralName(OBJGERALNAME,K);
switch(Ope){
case EDITEDIT_READONLY:ObjectSetInteger(ID,Name,OBJPROP_READONLY,(bool)Val);return;
case EDITEDIT_BORDERCOLOR:ObjectSetInteger(ID,Name,OBJPROP_BORDER_COLOR,(color)Val);return;

default: return;
}
return;
}



//+------------------------------------------------------------------+
//|PRIVATE DEFINITIONS                                               |
//+------------------------------------------------------------------+
long CControlPainel::SetXDistance(ENUM_BASE_CORNER Corner,long MARGIM,long WIDTH)
  {
   if(Corner==CORNER_LEFT_LOWER || Corner==CORNER_LEFT_UPPER)
     {
      return MARGIM;
     }
   return MARGIM+WIDTH;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long CControlPainel::SetYDistance(ENUM_BASE_CORNER Corner,long MARGIM,long HEIGTH)
  {
   if(Corner==CORNER_LEFT_LOWER || Corner==CORNER_RIGHT_LOWER)
     {
      return MARGIM+HEIGTH;
     }
   return MARGIM;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CControlPainel::ChangePanelAppearence()
  {
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_BGCOLOR,PanelBGColor))
      return false;
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_BORDER_TYPE,PanelBorder))
      return false;
   if(!ObjectSetInteger(ID,PanelName,OBJPROP_BORDER_COLOR,PanelBorderColor))
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::SetObjectYDimensions()
  {
   int MN=ArraySize(ButtonEditProp)+ArraySize(EditEditProp);
   
   int N=NumbersObjects+1-MN;
  // printf("NumberObj %d mn %d",NumbersObjects,MN);
   long PHeigth=PanelHeight;
   //if(N<=0)return;
   //if(MN<=0)return;
   ObjYMargim=(long)((PHeigth*OBJMARGIMX)/N);
   if(NumbersObjects-MN==0)return;
   ObjYSize=(long)(PHeigth*(1-OBJMARGIMX)/(NumbersObjects-MN));
   long Temp=(long)(PHeigth-ObjYMargim*N-ObjYSize*(NumbersObjects-MN));
   long K=0;
   long TempK=0;
   for(int i=0; i<30; i++)
     {
      TempK=(ObjYMargim-Temp-i)/2;
      if(TempK%2!=0)
         continue;
      K=TempK/2;
      break;
     }
   ObjAddYMargim=-K;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::SetObjectXDimensions()
  {
////////////////////////////
   long PWidth=PanelWidth;
   ObjXMargim=(long)(PWidth*(OBJMARGIMY)/2);
   ObjXSize=(long)(PWidth*(1-OBJMARGIMY));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CControlPainel::GetGeralName(const string GName,int N)const
  {
   string Temp=PanelName;
   StringAdd(Temp,GName);
   StringAdd(Temp,IntegerToString(N));
   return Temp;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long CControlPainel::SetYMargimObj(int i)
  {
   if(PanelCorner==CORNER_LEFT_UPPER || PanelCorner==CORNER_RIGHT_UPPER)
     {
      return ((ObjYMargim*i)+(ObjYSize*(i-1))+ObjAddYMargim);
     }
   long PanelW=PanelHeight;
   return (PanelW-((ObjYMargim*i)+(ObjYSize*(i-1)))-ObjAddYMargim);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CControlPainel::SetObjectsPlace()
  {
   SetObjectYDimensions();
   SetObjectXDimensions();
   string Name;
   long MargimY;
   int NButtonEdit=ArraySize(NumberButtonEdit);
   int NEditEdit=ArraySize(NumberEditEdit);
   int BEV=0;
   int EEV=0;
   int MY=0;
   
   for(int i=1; i<=NumbersObjects; i++)
     {
  if(BEV<NButtonEdit){
   if(NumberButtonEdit[BEV]==i){
      
      long BntWidth=(long)(ObjXSize*ButtonEditProp[BEV]);
      Name=GetGeralName(OBJGERALNAME,i);
      MargimY=YMargim+SetYMargimObj(i-MY);
      ObjectSetInteger(ID,Name,OBJPROP_CORNER,PanelCorner);
      ObjectSetInteger(ID,Name,OBJPROP_YDISTANCE,MargimY);
      ObjectSetInteger(ID,Name,OBJPROP_YSIZE,ObjYSize);
      ObjectSetInteger(ID,Name,OBJPROP_XDISTANCE,SetXDistance(PanelCorner,XMargim+ObjXMargim,ObjXSize));
      ObjectSetInteger(ID,Name,OBJPROP_XSIZE,BntWidth);
      ObjectSetString(ID,Name,OBJPROP_FONT,FontName);
      long EditWidth=(long)(ObjXSize*(1-ButtonEditProp[BEV]));
      Name=GetGeralName(OBJGERALNAME,i+1);
      ObjectSetInteger(ID,Name,OBJPROP_CORNER,PanelCorner);
      ObjectSetInteger(ID,Name,OBJPROP_YDISTANCE,MargimY);
      ObjectSetInteger(ID,Name,OBJPROP_YSIZE,ObjYSize);
      ObjectSetInteger(ID,Name,OBJPROP_XDISTANCE,SetXDistance(PanelCorner,XMargim+2*ObjXMargim+BntWidth,EditWidth-ObjXMargim));
      ObjectSetInteger(ID,Name,OBJPROP_XSIZE,EditWidth-ObjXMargim);
      ObjectSetString(ID,Name,OBJPROP_FONT,FontName);
       BEV++;
       i++;
       MY++;
       continue;
       }}
   if(EEV<NEditEdit){
    if(NumberEditEdit[EEV]==i){
     long BntWidth=(long)(ObjXSize*EditEditProp[EEV]);
      Name=GetGeralName(OBJGERALNAME,i);
      MargimY=YMargim+SetYMargimObj(i-MY);
      ObjectSetInteger(ID,Name,OBJPROP_CORNER,PanelCorner);
      ObjectSetInteger(ID,Name,OBJPROP_YDISTANCE,MargimY);
      ObjectSetInteger(ID,Name,OBJPROP_YSIZE,ObjYSize);
      ObjectSetInteger(ID,Name,OBJPROP_XDISTANCE,SetXDistance(PanelCorner,XMargim+ObjXMargim,ObjXSize));
      ObjectSetInteger(ID,Name,OBJPROP_XSIZE,BntWidth);
      ObjectSetString(ID,Name,OBJPROP_FONT,FontName);
      long EditWidth=(long)(ObjXSize*(1-EditEditProp[EEV]));
      Name=GetGeralName(OBJGERALNAME,i+1);
      ObjectSetInteger(ID,Name,OBJPROP_CORNER,PanelCorner);
      ObjectSetInteger(ID,Name,OBJPROP_YDISTANCE,MargimY);
      ObjectSetInteger(ID,Name,OBJPROP_YSIZE,ObjYSize);
      ObjectSetInteger(ID,Name,OBJPROP_XDISTANCE,SetXDistance(PanelCorner,XMargim+2*ObjXMargim+BntWidth,EditWidth-ObjXMargim));
      ObjectSetInteger(ID,Name,OBJPROP_XSIZE,EditWidth-ObjXMargim);
      ObjectSetString(ID,Name,OBJPROP_FONT,FontName);
       EEV++;
       i++;
       MY++;
       continue;
     
        
     }}
     
     
      Name=GetGeralName(OBJGERALNAME,i);
      MargimY=YMargim+SetYMargimObj(i-MY);
      ObjectSetInteger(ID,Name,OBJPROP_CORNER,PanelCorner);
      ObjectSetInteger(ID,Name,OBJPROP_YDISTANCE,MargimY);
      ObjectSetInteger(ID,Name,OBJPROP_YSIZE,ObjYSize);
      ObjectSetInteger(ID,Name,OBJPROP_XDISTANCE,SetXDistance(PanelCorner,XMargim+ObjXMargim,ObjXSize));
      ObjectSetInteger(ID,Name,OBJPROP_XSIZE,ObjXSize);
      ObjectSetString(ID,Name,OBJPROP_FONT,FontName);
      
     }




  }

void CControlPainel::SetPanelOnTop(){
string OBJName="";

for(int i=ObjectsTotal(ID);i>=0;i--){
OBJName=ObjectName(ID,i);
if(OBJName==PanelName || PanelNameCompare(OBJName,OBJGERALNAME)){
ObjectSetInteger(ID,OBJName,OBJPROP_BACK,false);
continue;}  
ObjectSetInteger(ID,OBJName,OBJPROP_BACK,true);
}

}

bool CControlPainel::PanelNameCompare(const string OBJName,const string GeralName)const{
const string NameObjects=GetGeralName(GeralName,0);
const int ObjSize=StringLen(OBJName);
const int NameSize=StringLen(NameObjects);
if(NameSize>ObjSize)return false;
for(int i=0;i<NameSize-1;i++){
if(OBJName[i]!=NameObjects[i])return false;
}

return true;
}


bool CControlPainel::ButtonGetState(int N){
  return (bool)ButtonGetInteger(N,BUTTON_STATE);
}

void CControlPainel::ButtonSetState(int N,bool state){
  ButtonSetInteger(N,BUTTON_STATE,state);
}
#endif
//+------------------------------------------------------------------+
